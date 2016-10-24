package;

/**
 * ...
 * @author ...
 */
class Reg
{
	static public var coliPiso = false; 
		
	static public function Approach (a:Float, b:Float, c:Float)
	{
		if (a < b)
			return a + c;
		else
			return a - c;
	}
}
