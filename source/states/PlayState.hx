package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import sprites.Ataque;
import sprites.Enemy1;
import sprites.Enemy2;
import sprites.Enemy3;
import sprites.Enemy4;
import sprites.Piso;
import sprites.PlatformH;
import sprites.Player;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;
import sprites.TheBoss;

class PlayState extends FlxState
{
	private var player:Player;
	private var tilemap:FlxTilemap;
	private var fondo:FlxBackdrop;
	private var enemy:Enemy1;
	private var enemy2:Enemy2;
	private var enemy3:Enemy3;
	private var enemy4:Enemy4;
	private var boss:TheBoss;
	private var ataque:Ataque;
	
	private var platGroupH:FlxTypedGroup<PlatformH>;
	
	
	public  function entityCreator(name:String, data:Xml):Void
	{	
		var startX:Float =  Std.parseFloat(data.get("x"));
		var startY:Float = Std.parseFloat(data.get("y"));
		switch (name)
		{
			case "platformH":
				platGroupH.add(new PlatformH(Std.parseInt(data.get("counter")),data.get("direcction"),startX, startY));
			case "platformV":	
		}
		
	}
	
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		fondo = new FlxBackdrop(AssetPaths.Fondo__png, 1, 0, true, false);
		add(fondo);
		
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.LevelOne__oel);
		tilemap = loader.loadTilemap(AssetPaths.BuildingTileset__png, 16, 16, "Buildings");
		tilemap.setTileProperties(0, FlxObject.NONE);
		for (i in 1...348)
			tilemap.setTileProperties(i, FlxObject.ANY);
		add(tilemap);
		
		
		player = new Player(32, 32);
		add(player);
		enemy = new Enemy1(200, 0);
		add(enemy);
		enemy2 = new Enemy2(FlxG.width, 150);
		add(enemy2);
		enemy3 = new Enemy3(100, 100);
		add(enemy3);
		enemy4 = new Enemy4(110, 100);
		add(enemy4);
		boss = new TheBoss(200, 60);
		add(boss);
		ataque = new Ataque(32, 32);
		add(ataque);
		add(Reg.enemyBullets);
		ataque.kill();
		
		platGroupH = new FlxTypedGroup<PlatformH>();

		add(platGroupH);
		
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		loader.loadEntities(entityCreator, "Entities");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.playerX = player.x;
		Reg.playerY = player.y;
		
		if (FlxG.keys.justPressed.P){
			ataque.revive();
			switch(player.getDirec()){
			case true:
				ataque.x = Reg.playerX + 15;
				ataque.y = Reg.playerY + 40;
			case false:
				ataque.x = Reg.playerX - 15;
				ataque.y = Reg.playerY + 40;
			}
		}
		else 
			ataque.kill();	
		FlxG.collide(player, tilemap);
		FlxG.collide(enemy, tilemap);
		FlxG.collide(enemy3, tilemap);
		FlxG.collide(enemy4, tilemap);
		FlxG.collide(Reg.enemyBullets, tilemap);
		if (FlxG.overlap(enemy, ataque))
			enemy.destroy();
		if (FlxG.overlap(enemy2, ataque))
			enemy2.destroy();
		if (FlxG.overlap(enemy3, ataque))
			enemy3.destroy();
		/*	
		if (FlxG.pixelPerfectOverlap(player, enemy))
			player.kill();
		if (FlxG.pixelPerfectOverlap(player, enemy2))
			player.kill();
		*/	
		//No se porque tienen que estar los dos if para que ande, no tengo idea de porque, si saco alguno deja de colisionar
		//
		//if (FlxG.collide(player,Reg.enemyBullets)){}
		for (i in 0...Reg.enemyBullets.length)
		{
			if (FlxG.overlap(player,Reg.enemyBullets.members[i]))
				player.kill();
		}
		//
		if (FlxG.keys.pressed.R) // nose porque crashea al darle reset :'v
			FlxG.resetState();
	}
	
}
