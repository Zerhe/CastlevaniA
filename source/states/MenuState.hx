package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flash.system.System;
import flixel.math.FlxMath;
import openfl.Lib;

class MenuState extends FlxState
{
	private var title:FlxText;
	private var nombres:FlxText;

	private var play:FlxButton;
	private var salir:FlxButton;
	
	private var splash:Bool;
	private var counter:Int;
	override public function create():Void
	{
		super.create();
		splash = false;
		counter = 0;
		title = new FlxText(80, 30);
		title.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFFFF0000);
		title.text = "Final Destination III";
		title.scale.x = 2;
		title.scale.y = 2;
		title.kill();
		nombres = new FlxText(80,100);
		nombres.text = "    Lucas Abreu\n Rodrigo Amarilla\nJoaquin Liberatore";
		nombres.scale.x = 1.4;
		nombres.scale.y = 1.4;
		
		play = new FlxButton(82, 120, "Jugar");
		play.kill();
		//
		//salir = new FlxButton(82, 170, "Salir");
		//salir.kill();
		
		add(title);
		add(nombres);
		add(play);
		add(salir);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (!splash)
		{
			counter++;
			if (counter == 180)
			{
				splash = true;
				nombres.kill();
				title.revive();
				play.revive();
				play.draw();
				salir.revive();
				salir.draw();
			}
		}
		else
		{
			if (play.justReleased)
				FlxG.switchState(new PlayState());

		}
	}
}
