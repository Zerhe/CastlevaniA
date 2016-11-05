package;
import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.EnemyBullet;
import sprites.Laser;
import sprites.Ataque;
/**
 * ...
 * @author ...
 */
class Reg
{
	//static public var coliPiso:Bool = false;
	static public var playerDirec:Bool; 
	static public var playerX:Float = 0;
	static public var playerY:Float = 0;
	static public var AccGravedad:Float = 700;
	static public var enemyBullets:FlxTypedGroup<EnemyBullet> = new FlxTypedGroup<EnemyBullet>();
	static public var BossBullets:FlxTypedGroup<EnemyBullet> = new FlxTypedGroup<EnemyBullet>();
	static public var laserGroup:FlxTypedGroup<Laser> = new FlxTypedGroup<Laser>();
	static public var ataque:Ataque = new Ataque(32, 32);
	
	static public function Approach (a:Float, b:Float, c:Float)
	{
		if (a < b)
			return a + c;
		else
			return a - c;
	}
}
