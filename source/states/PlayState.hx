package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Piso;
import sprites.Player;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
	private var player:Player;
	private var piso:Piso;
	private var fondo:FlxBackdrop;
	
	override public function create():Void
	{
		super.create();
		fondo = new FlxBackdrop(AssetPaths.Fondo__png, 1, 0, true, false);
		add(fondo);
		
		player = new Player(32, 32);
		add(player);
		piso = new Piso(0, 200);
		add(piso);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.overlap(player, piso) && player.getSalto() == false)
		{
			player.velocity.y = 0;
			Reg.coliPiso = true;
			trace(Reg.coliPiso);
		}
		else 
			Reg.coliPiso = false;
		
		if (FlxG.keys.pressed.R)
			FlxG.resetState();
	}
}
