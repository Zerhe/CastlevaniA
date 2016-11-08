package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import haxe.ds.ObjectMap;
import sprites.Ataque;
import sprites.Enemy1;
import sprites.Enemy2;
import sprites.Enemy3;
import sprites.Enemy4;
import sprites.ObjDes;
import sprites.PickUp;
import sprites.Piso;
import sprites.PlatformH;
import sprites.PlatformV;
import sprites.Player;
import sprites.TheBoss;
import sprites.BaseEnemies;
import sprites.EnemyBullet;
import sprites.TheBossDrone;
import sprites.Laser;
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
	
	private var ataque:Ataque;
	
	private var healthBar:FlxBar;
	private var laserText:FlxText;
	
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
			case "Enemy1":
				Reg.enemyGroup.add(new Enemy1(startX, startY));
			case "Enemy2":
				Reg.enemyGroup.add(new Enemy2(startX, startY));
			case "Enemy3":
				Reg.enemyGroup.add(new Enemy3(startX, startY));
			case "Enemy4":
				Reg.enemyGroup.add(new Enemy4(startX, startY));
			case "ObjDes":
				Reg.objDesGroup.add(new ObjDes(startX, startY));
		}	
	}
	
	private function spawnEntities():Void
	{
		for (i in 0...Reg.enemyGroup.length) 
		{
			if (!Reg.enemyGroup.members[i].alive) 
			{
				if (Reg.enemyGroup.members[i].x <= (FlxG.camera.scroll.x + FlxG.camera.width + Reg.enemyGroup.members[i].width))
					Reg.enemyGroup.members[i].revive();
			}
		}
		for (i in 0...Reg.objDesGroup.length) 
		{
			if (!Reg.objDesGroup.members[i].alive) 
			{
				if (Reg.objDesGroup.members[i].x <= (FlxG.camera.scroll.x + FlxG.camera.width + Reg.objDesGroup.members[i].width))
					Reg.objDesGroup.members[i].revive();
			}
		}
	}
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		
		Reg.AccGravedad = 700;
		Reg.enemyBullets = new FlxTypedGroup<EnemyBullet>();
		Reg.BossBullets = new FlxTypedGroup<EnemyBullet>();
		Reg.bossDrones = new FlxTypedGroup<TheBossDrone>();
		Reg.laserGroup = new FlxTypedGroup<Laser>();
		Reg.enemyGroup = new FlxTypedGroup<BaseEnemies>();
		Reg.pickUpGroup = new FlxTypedGroup<PickUp>(); 
		Reg.objDesGroup	= new FlxTypedGroup<ObjDes>();	
		
		
		
		
		
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
		Reg.tileWidth = tilemap.width;
		player = new Player(32, 32);
		add(player);
		add(Reg.enemyGroup);
		
		
		enemy = new Enemy1(200, 0);
		add(enemy);
		enemy2 = new Enemy2(FlxG.width, 150);
		add(enemy2);
		enemy3 = new Enemy3(100, 100);
		add(enemy3);
		enemy4 = new Enemy4(110, 100);
		add(enemy4);
		
		Reg.objDesGroup.add(new ObjDes(50, 100));
		
		boss = new TheBoss(200, 60);
		add(boss);
		ataque = new Ataque();
		add(ataque);
		add(Reg.enemyBullets);
		add(Reg.BossBullets);
		add(Reg.bossDrones);
		add(Reg.laserGroup);
		add(Reg.objDesGroup);
		add(Reg.pickUpGroup);
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
		
		healthBar = new FlxBar(10, 10);
		healthBar.parent = player;
		healthBar.parentVariable = "health";
		add(healthBar);
		laserText = new FlxText(0,20);
		add(laserText);
	}

	override public function update(elapsed:Float):Void
	{
		if (player.health <= 0)
			FlxG.switchState(new GameOverState());
		super.update(elapsed);
		spawnEntities();
		healthBar.x = FlxG.camera.scroll.x + 5;
		laserText.x = FlxG.camera.scroll.x + 5;
		laserText.text = "Laser Ammo: " + player.getLaserAmmo();
		Reg.playerX = player.x;
		Reg.playerY = player.y;
		if (FlxG.keys.justPressed.P)
			ataque.respawn(player.getDirec());
		else 
			ataque.kill();	
		FlxG.collide(player, tilemap);
		FlxG.collide(Reg.enemyGroup, tilemap);
		FlxG.collide(enemy, tilemap);
		FlxG.collide(enemy3, tilemap);
		FlxG.collide(enemy4, tilemap);
		FlxG.collide(Reg.enemyBullets, tilemap);
		FlxG.collide(player, platGroupH);
		FlxG.collide(player, platGroupV, aplasta); 
		FlxG.collide(Reg.pickUpGroup, tilemap);
		
		for (i in 0...Reg.enemyGroup.length) 
		{
			if (FlxG.overlap(Reg.enemyGroup.members[i], ataque))
				Reg.enemyGroup.members[i].destroy();
			for (j in 0...Reg.laserGroup.length) 
			{
				if (FlxG.overlap(Reg.enemyGroup.members[i],Reg.laserGroup.members[j]))
				{
					Reg.enemyGroup.members[i].destroy();
					Reg.laserGroup.members[j].destroy();
				}
			}
		}
		for (i in 0...Reg.objDesGroup.length) 
		{
			if (FlxG.overlap(Reg.objDesGroup.members[i], ataque))
				Reg.objDesGroup.members[i].destruir();
		}
		for (i in 0...Reg.pickUpGroup.length) 
		{
			if (FlxG.overlap(Reg.pickUpGroup.members[i], player))
				Reg.pickUpGroup.members[i].agarrar(player);
		}
		if (FlxG.overlap(enemy, ataque))
			enemy.destroy();
		if (FlxG.overlap(enemy2, ataque))
			enemy2.destroy();
		if (FlxG.overlap(enemy3, ataque))
			enemy3.destroy();
		if (FlxG.overlap(player, Reg.enemyGroup))
			player.daniar();
		//No se porque tienen que estar los dos if para que ande, no tengo idea de porque, si saco alguno deja de colisionar
		//
		//if (FlxG.collide(player,Reg.enemyBullets)){}
		for (i in 0...Reg.enemyBullets.length)
		{
			if (FlxG.overlap(player,Reg.enemyBullets.members[i]))
				player.daniar();
		}
		//
		if (FlxG.keys.pressed.R) // nose porque crashea al darle reset :'v
			FlxG.resetState();
			
		if (FlxG.overlap(player, transportador))
		{	
			Reg.playerHealth = player.health;
			Reg.laserAmmo = player.getLaserAmmo();
			FlxG.switchState(new BossState());
		}
		for(i in 0...5){
			add(Reg.BossBullets.members[i]);	
		}
	}
	
	private function aplasta(p:Player, v:PlatformV):Void
	{
		if (p.isTouching(FlxObject.CEILING))
			p.kill();
	}
	
	
}
