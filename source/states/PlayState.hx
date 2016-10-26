package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Ataque;
import sprites.Enemy1;
import sprites.Piso;
import sprites.Player;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
	private var player:Player;
	private var piso:Piso;
	private var fondo:FlxBackdrop;
	private var enemy:Enemy1;
	private var ataque:Ataque;
	
	override public function create():Void
	{
		super.create();
		fondo = new FlxBackdrop(AssetPaths.Fondo__png, 1, 0, true, false);
		add(fondo);
		
		player = new Player(32, 32);
		add(player);
		piso = new Piso(0, 200);
		add(piso);
		enemy = new Enemy1(200, 0);
		add(enemy);
		ataque = new Ataque(32, 32);
		add(ataque);
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
			
		if (FlxG.overlap(player, piso) && player.getSalto() == false)
		{
			player.velocity.y = 0;
			Reg.coliPiso = true;
		}
		else 
			Reg.coliPiso = false;
		if (FlxG.overlap(enemy, piso))
			enemy.OnFloor(true);
		else
			enemy.OnFloor(false);
		if (FlxG.overlap(enemy, ataque))
			enemy.destroy();
		if (FlxG.pixelPerfectOverlap(player, enemy))
			trace("se murio");
		if (FlxG.keys.pressed.R)
			FlxG.resetState();
	}
}
