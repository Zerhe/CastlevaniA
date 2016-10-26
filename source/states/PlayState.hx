package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
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
import sprites.Piso;
import sprites.Player;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
	private var player:Player;
	private var tilemap:FlxTilemap;
	private var fondo:FlxBackdrop;
	private var enemy:Enemy1;
	private var enemy2:Enemy2;
	private var enemy3:Enemy3;
	private var ataque:Ataque;
	
	override public function create():Void
	{
		super.create();
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
		ataque = new Ataque(32, 32);
		add(ataque);
		add(Reg.enemyBullets);
		ataque.kill();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.playerX = player.x;
		Reg.playerY = player.y;
		
		if (FlxG.keys.justPressed.P){
			ataque.revive();
			ataque.x = Reg.playerX + 15;
			ataque.y = Reg.playerY + 10;
		}
		else 
			ataque.kill();	
		FlxG.collide(player, tilemap);
		FlxG.collide(enemy, tilemap);
		FlxG.collide(enemy3, tilemap);
		FlxG.collide(Reg.enemyBullets, tilemap);
		if (FlxG.overlap(enemy, ataque))
			enemy.destroy();
			
		if (FlxG.pixelPerfectOverlap(player, enemy))
			player.kill();
		if (FlxG.pixelPerfectOverlap(player, enemy2))
			player.kill();
			
		//No se porque tienen que estar los dos if para que ande, no tengo idea de porque, si saco alguno deja de colisionar
		//
		if (FlxG.collide(player,Reg.enemyBullets)){}
		for (i in 0...Reg.enemyBullets.length)
		{
			if (FlxG.collide(player,Reg.enemyBullets.members[i]))
				player.kill();
		}
		//
		if (FlxG.keys.pressed.R)
			FlxG.resetState();
	}
	
}
