package states;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sprites.Player;
import flixel.FlxG;
class BossState extends FlxSubState
{
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	private var player:Player;
	private var fondo:FlxSprite;
	override public function create():Void 
	{
		super.create();
		FlxG.mouse.visible = false;
		fondo = new FlxSprite();
		fondo.loadGraphic(AssetPaths.BackgroundTrenAnim__png, true, 256, 240);
		fondo.animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8], 24, true);
		fondo.animation.play("idle");
		add(fondo);
		loader = new FlxOgmoLoader(AssetPaths.LevelBoss__oel);
		tilemap = loader.loadTilemap(AssetPaths.TrenTile__png, 16, 16, "Buildings");
		tilemap.setTileProperties(0, FlxObject.NONE);
		for (i in 1...50) 
			tilemap.setTileProperties(i, FlxObject.ANY);
		add(tilemap);
		player = new Player();
		player = Reg.playerAux;
		player.y = 50;
		player.x = 50;
		add(player);
		trace(player.asd);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.collide(player, tilemap);
		trace(player.x);
		trace(player.y);
	}
}