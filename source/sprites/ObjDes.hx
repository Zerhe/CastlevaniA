package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class ObjDes extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Chest__png, true, 16, 16);
		animation.add("idle", [0, 1], 4, true);
		animation.play("idle");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (this.x > (FlxG.camera.scroll.x + FlxG.camera.width + this.width*2) && this.alive)
			kill();
		else if (this.x < (FlxG.camera.scroll.x - this.width * 2) && this.alive)
			kill();
	}
	public function destruir():Void 
	{
		Reg.pickUpGroup.add(new PickUp(x, y));
		destroy();
	}
}