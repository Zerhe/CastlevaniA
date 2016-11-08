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
		trace(timer);
		trace(Reg.playerDirec);	
		
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
				Reg.BossBullets.members[0].boss(50);
				Reg.BossBullets.add(Reg.BossBullets.members[0]);
			case 450:
				Reg.BossBullets.members[1] = new EnemyBullet(x + width / 2, y);
				Reg.BossBullets.members[1].boss(65);
				Reg.BossBullets.add(Reg.BossBullets.members[1]);
			case 500:
				Reg.BossBullets.members[2] = new EnemyBullet(x + width / 2, y);
				Reg.BossBullets.members[2].boss(80);
				Reg.BossBullets.add(Reg.BossBullets.members[2]);
			case 550:
				Reg.BossBullets.members[3] = new EnemyBullet(x + width / 2, y);
				Reg.BossBullets.members[3].boss(95);
				Reg.BossBullets.add(Reg.BossBullets.members[3]);
			case 600:
				Reg.BossBullets.members[4] = new EnemyBullet(x + width / 2, y);
				Reg.BossBullets.members[4].boss(110);
				Reg.BossBullets.add(Reg.BossBullets.members[4]);
			case 700:
				Reg.bossDrones.add(new TheBossDrone(x + width / 2, y - 50));
			case 800:
				Reg.bossDrones.add(new TheBossDrone(x + width / 2, y - 50));
			case 900:
				Reg.bossDrones.add(new TheBossDrone(x + width / 2, y - 50));
			case 1000:
				timer = 0;
		}
	}
}