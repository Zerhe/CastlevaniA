package;

/**
 * ...
 * @author ...
 */
class Reg
{
	static public var coliPiso:Bool = false;
	static public var playerX:Float = 0;
	static public var playerY:Float = 0;
		
	static public function Approach (a:Float, b:Float, c:Float)
	{
		if (a < b)
			return a + c;
		else
			return a - c;
	}
}
