package;
import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.EnemyBullet;
import sprites.Laser;
import sprites.Ataque;
import sprites.Player;
import sprites.BaseEnemies;
import sprites.PickUp;
import sprites.ObjDes;
import sprites.TheBossDrone;
/**
 * ...
 * @author ...
 */
class Reg
{
	//static public var coliPiso:Bool = false;
	static public var playerDirec:Bool; 
	static public var playerX:Float;
	static public var playerY:Float;
	static public var playerHealth:Float;
	static public var playerCrouch:Bool;
	static public var playerSalto:Bool;
	static public var laserAmmo:Int;
	static public var mejoro:Bool;
	static public var AccGravedad:Float;/*= 700;*/
	static public var enemyBullets:FlxTypedGroup<EnemyBullet>; /*= new FlxTypedGroup<EnemyBullet>();*/
	static public var BossBullets:FlxTypedGroup<EnemyBullet>; /*= new FlxTypedGroup<EnemyBullet>();*/
	static public var bossDrones:FlxTypedGroup<TheBossDrone>;
	static public var laserGroup:FlxTypedGroup<Laser>; /*= new FlxTypedGroup<Laser>();*/
	static public var enemyGroup:FlxTypedGroup<BaseEnemies>; /*= new FlxTypedGroup<BaseEnemies>();*/
	static public var pickUpGroup:FlxTypedGroup<PickUp>;/*= new FlxTypedGroup<PickUp>();*/
	static public var objDesGroup:FlxTypedGroup<ObjDes>; /*= new FlxTypedGroup<ObjDes>();*/
	static public var playerAux:Player;
	static public var tileWidth:Float;
}
