package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Enemy4 extends BaseEnemies
{
	private var loca:Int = 0;
	private var salto:Bool = false;
	private var saltoDer:Bool = false;
	private var saltoIzq:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 32);
		acceleration.y = Reg.AccGravedad;
		
	}
	override public function update(elapsed:Float):Void 
	{
		if (Reg.playerX > x)
			loca = 1;
		if (Reg.playerX < x)
			loca = 0;
		if (Reg.playerX > x - 50 && !salto && loca == 0)
			saltoIzq = true;
		if (Reg.playerX < x + 66 && !salto && loca == 1)
			saltoDer = true;
		
		if (saltoIzq == true) {
			salto = true;
			velocity.y = -VYMax;
			velocity.x = -100;
			saltoIzq = false;
			trace("asd");
		}
		if (saltoDer == true) {
			salto = true;	
			velocity.y = -VYMax;
			velocity.x = 100;
			saltoDer = false;
		}
		if (isTouching(FlxObject.FLOOR) && salto){
			salto = false;
			velocity.x = 0;
		}

		super.update(elapsed);	
	}
	
}