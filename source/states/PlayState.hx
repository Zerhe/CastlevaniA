package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
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
import sprites.PlatformV;
import sprites.Player;
import sprites.TheBoss;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	private var player:Player;
	private var tilemap:FlxTilemap;
	private var fondoTilemap:FlxTilemap;
	private var fondo2Tilemap:FlxTilemap;

	private var enemy:Enemy1;
	private var enemy2:Enemy2;
	private var enemy3:Enemy3;
	private var enemy4:Enemy4;
	private var boss:TheBoss;
	
	private var platGroupH:FlxTypedGroup<PlatformH>;
	private var platGroupV:FlxTypedGroup<PlatformV>;
	
	private var transportador:FlxSprite;
	private var bossSubState:FlxSubState;
	private var bossLevel:BossState;
	
	public  function entityCreator(name:String, data:Xml):Void
	{	
		var startX:Float =  Std.parseFloat(data.get("x"));
		var startY:Float = Std.parseFloat(data.get("y"));
		switch (name)
		{
			case "PlatformH":
				platGroupH.add(new PlatformH(Std.parseInt(data.get("Counter")),data.get("direcction"),startX, startY));
			case "PlatformV":	
				platGroupV.add(new PlatformV(Std.parseInt(data.get("Counter")), startX, startY));
		}
		
	}
	
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		
		bossSubState = new FlxSubState(0x00000000);
		
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.LevelOne__oel);
		fondoTilemap = loader.loadTilemap(AssetPaths.Background__png, 256, 240, "Background");
		add(fondoTilemap);
		fondo2Tilemap = loader.loadTilemap(AssetPaths.BackgroundLab__png, 256, 240, "BackgroundLab");
		add(fondo2Tilemap);
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
		add(Reg.ataque);
		add(Reg.enemyBullets);
		add(Reg.BossBullets);
		add(Reg.laserGroup);

		
		platGroupH = new FlxTypedGroup<PlatformH>();
		add(platGroupH);
		platGroupV = new FlxTypedGroup<PlatformV>();
		add(platGroupV);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		loader.loadEntities(entityCreator, "Entities");
		
		
		transportador = new FlxSprite(256, 80);
		transportador.makeGraphic(40, 40, 0xFF991345);
		add(transportador);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.playerX = player.x;
		Reg.playerY = player.y;
		
		if (FlxG.keys.justPressed.P){
			Reg.ataque.revive();
			switch(player.getDirec()){
			case true:
				Reg.ataque.x = Reg.playerX + 15;
				Reg.ataque.y = Reg.playerY + 30;
			case false:
				Reg.ataque.x = Reg.playerX - 15;
				Reg.ataque.y = Reg.playerY + 30;
			}
		}
		else 
			Reg.ataque.kill();	
		FlxG.collide(player, tilemap);
		FlxG.collide(enemy, tilemap);
		FlxG.collide(enemy3, tilemap);
		FlxG.collide(enemy4, tilemap);
		FlxG.collide(Reg.enemyBullets, tilemap);
		FlxG.collide(player, platGroupH);
		FlxG.collide(player, platGroupV, aplasta);                                     
		if (FlxG.overlap(enemy, Reg.ataque))
			enemy.destroy();
		if (FlxG.overlap(enemy2, Reg.ataque))
			enemy2.destroy();
		if (FlxG.overlap(enemy3, Reg.ataque))
			enemy3.destroy();
		player.asd = "ssssssssssssss";
		//if (FlxG.pixelPerfectOverlap(player, enemy))
			//player.kill();
		//if (FlxG.pixelPerfectOverlap(player, enemy2))
			//player.kill();
			
		//No se porque tienen que estar los dos if para que ande, no tengo idea de porque, si saco alguno deja de colisionar
		//
		//if (FlxG.collide(player,Reg.enemyBullets)){}
		//for (i in 0...Reg.enemyBullets.length)
		//{
			//if (FlxG.overlap(player,Reg.enemyBullets.members[i]))
				//player.kill();
		//}
		//
		if (FlxG.keys.pressed.R) // nose porque crashea al darle reset :'v
			FlxG.resetState();
			
		if (FlxG.overlap(player, transportador))
		{
			Reg.playerAux = player;
			
			openSubState(bossLevel);
			FlxG.switchState(new BossState());
		}
	}
	
	private function aplasta(p:Player, v:PlatformV):Void
	{
		if (p.isTouching(FlxObject.CEILING))
			p.kill();
	}
	
}
