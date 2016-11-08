package states;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.system.FlxSound;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sprites.Player;
import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
class BossState extends FlxSubState
{
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	private var player:Player;
	private var fondo:FlxSprite;
	private var healthBar:FlxBar;
	private var laserText:FlxText;
	private var trenSound:FlxSound;
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
		Reg.tileWidth = tilemap.width;
		player = new Player();
		player.y = 0-player.height;
		player.x = 50;
		player.setLaserAmmo(Reg.laserAmmo);
		player.health = Reg.playerHealth;
		add(player);
		healthBar = new FlxBar(10, 10);
		healthBar.parent = player;
		healthBar.parentVariable = "health";
		add(healthBar);
		laserText = new FlxText(0,20);
		add(laserText);
		trenSound = new FlxSound();
		trenSound.loadEmbedded(AssetPaths.tren__wav);
		trenSound.volume = 0.2;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		trenSound.play();
		healthBar.x = FlxG.camera.scroll.x + 5;
		laserText.x = FlxG.camera.scroll.x + 5;
		laserText.text = "Laser Ammo: " + player.getLaserAmmo();
		FlxG.collide(player, tilemap);
	}
}