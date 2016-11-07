package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import Reg;

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
		//trace(timer);
		//trace(Reg.playerDirec);	
		
		switch (timer){
			case 200:
				switch(Reg.playerDirec){
					case true:
						x = Reg.playerX - 40 - width;
					case false:
						x = Reg.playerX + 56;		
			}
			case 400:
				Reg.BossBullets.members[0] = new EnemyBullet(x + width / 2, y);
				Reg.BossBullets.members[0].boss();
				Reg.BossBullets.add(Reg.BossBullets.members[0]);
			case 450:
				Reg.BossBullets.add(new EnemyBullet(x+width/2, y));
			case 500:
				Reg.BossBullets.add(new EnemyBullet(x+width/2, y));
			case 550:
				Reg.BossBullets.add(new EnemyBullet(x+width/2, y));
			case 600:
				Reg.BossBullets.add(new EnemyBullet(x+width/2, y));
			case 700:
				timer = 0;
		}
	}
}