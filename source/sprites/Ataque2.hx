package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Ataque2 extends FlxSprite
{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{

		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Blast2__png, true, 48, 8);
		animation.add("shootR", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 30, false);
		animation.add("shootL", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 30, false,true);
		kill();
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (Reg.playerDirec)
			x = Reg.playerX + 24;
		else
			x = Reg.playerX - 48;
		if (!Reg.playerCrouch)
			y = Reg.playerY + 12;		
		else
			y = Reg.playerY + 20;	
		if (animation.finished)
			kill();
	}
	override public function revive():Void 
	{
		super.revive();
		if (Reg.playerDirec)
			animation.play("shootR");
		else 
			animation.play("shootL");
	}
}