package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
class GameOverState extends FlxState
{
	private var gameOverText:FlxText;
	private var jugarButton:FlxButton;
	private var salirButton:FlxButton;
	override public function create():Void 
	{
		super.create();
		FlxG.mouse.visible = true;
		gameOverText = new FlxText(100, 100);
		gameOverText.text = "Game Over";
		gameOverText.scale.x = 2;
		gameOverText.scale.y = 2;
		add(gameOverText);
		jugarButton = new FlxButton(32, 150,"Jugar de nuevo");
		add(jugarButton);
		salirButton = new FlxButton(142, 150, "Salir"); 
		add(salirButton);
		
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (jugarButton.justReleased)
			FlxG.switchState(new PlayState());
		else if (salirButton.justReleased)
			Sys.exit(0);
	}	
}