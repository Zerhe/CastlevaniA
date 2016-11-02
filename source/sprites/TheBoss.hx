package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class TheBoss extends FlxSprite
{
	private var timer:Int = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(64, 64);
		
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		timer++;
		trace(timer);
		trace(Reg.playerDirec);
		switch (timer){
			case 300:
				switch(Reg.playerDirec){
					case true:
						x = Reg.playerX - 40 - width;
					case false:
						x = Reg.playerX + 56;		
			}
		
		case 400:
			Reg.enemyBossBullets.add(new EnemyBullet(x, y));
		case 420:
			Reg.enemyBossBullets.add(new EnemyBullet(x, y));
		case 440:
			Reg.enemyBossBullets.add(new EnemyBullet(x, y));
		case 460:
			Reg.enemyBossBullets.add(new EnemyBullet(x, y));
		case 480:
			Reg.enemyBossBullets.add(new EnemyBullet(x, y));
		if (timer == 500)
			timer = 0;
		}
	}
}