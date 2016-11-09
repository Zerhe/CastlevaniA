package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.system.FlxSound;
class Player extends FlxSprite
{
	private var Multiplier:Float = 20.0;
	private var VYMax:Float;
	private var salto:Bool = false;
	private var direc = true;
	private var crouch:Bool = false;
	private var atacando:Bool = false;
	private var pickUp:Int = -1;
	private var laserAmmo:Int = 0; 
	private var laserCounter:Int = 0;
	private var puedeDisparar:Bool = true;
	private var invulnerable:Bool = false;
	private var invulCounter:Int = 0;
	private var invulEfectCounter:Int = 0;
	private var contained:Bool = false;
	private var soundCounter:Int = 0;
	private var runSound:FlxSound;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Cyborg__png, true, 24, 46);
		animation.add("idleR", [2], 1, true);
		animation.add("idleL", [0], 1, true);
		animation.add("runR", [4, 5, 6, 7, 8, 9, 10], 10, true);
		animation.add("runL", [11, 12, 13, 14, 15, 16, 17], 10, true);
		animation.add("crouchR", [3], 5, true);
		animation.add("crouchL", [1], 5, true);
		animation.add("attackR", [18, 19, 20, 21], 10, false);
		animation.add("attackL", [22, 23, 24, 25], 10, false);
		animation.add("attackCR", [26, 27, 28, 29], 10, false);
		animation.add("attackCL", [30, 31, 32, 33], 10, false);
		VYMax       = 13   * Multiplier;
		acceleration.y = Reg.AccGravedad;
		health = 100;
		runSound = new FlxSound();
		runSound.loadEmbedded(AssetPaths.caminar__wav);
		runSound.volume = 0.5;
	}
	override public function update(elapsed:Float):Void
	{	
		Reg.playerDirec = direc;
		movement();	
		Reg.playerCrouch = crouch;
		Reg.playerSalto = salto;
		if (!invulnerable) 
		{
			if (!puedeDisparar)
				laserCounter++;
			if (laserCounter == 30)
			{
				laserCounter = 0;
				puedeDisparar = true;
			}
			if (FlxG.keys.pressed.SPACE && laserAmmo > 0 && puedeDisparar) 
			{
				FlxG.sound.play(AssetPaths.disparolaser__wav);
				Reg.laserGroup.add(new Laser(direc, x, y+20));
				puedeDisparar = false;
				laserAmmo--;
			}			
		}
		else 
			invulEffect();
		super.update(elapsed); 
	}
	public function getDirec(): Bool
	{
		return direc;
	}	
	public function agarrarPickUp(num:Int):Void
	{
		pickUp = num;
		switch(num)
		{
			case 0:
				{
					health += 10;
					if (health > 100)
						health -= (health - 100);
				}
			case 1:
				Reg.mejoro = true;
			case 2:
				laserAmmo += 5;
		}
	}
	public function getPickUp():Int
	{
		return pickUp;
	}
	public function movement():Void
	{
		soundCounter++;
		if (isTouching(FlxObject.FLOOR))
		{
			velocity.x = 0;		
			salto = false;
		}
		else
			salto = true;
		if (FlxG.keys.pressed.LEFT && !salto)
		{
			if (x <= 0)
				velocity.x = 0;
			else
				velocity.x -= 100;
			direc = false;
			animation.play("runL");
			if (soundCounter == 15)
			{
				runSound.play();
				soundCounter = 0;
			}
		}
		if (FlxG.keys.pressed.RIGHT && !salto) 
		{
			if (x > (Reg.tileWidth-this.width))
				velocity.x = 0;
			else
				velocity.x += 100; 
			direc = true;
			animation.play("runR");
			if (soundCounter == 15)
			{
				runSound.play();
				soundCounter = 0;
			}
		}	
		if (FlxG.keys.pressed.UP && FlxG.keys.pressed.RIGHT && isTouching(FlxObject.FLOOR))
		{	
			velocity.y = -VYMax;
			if (x > (Reg.tileWidth-this.width))
				velocity.x = 0;
			salto = true;
			animation.play("crouchR");
		}
		else if (FlxG.keys.pressed.UP && FlxG.keys.pressed.LEFT && isTouching(FlxObject.FLOOR))
		{	
			velocity.y = -VYMax;
			if (x <= 0)
				velocity.x = 0;

			salto = true;
			animation.play("crouchL");
		}
		else if (FlxG.keys.pressed.UP && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -VYMax;
			salto = true;
		}
		if (FlxG.keys.pressed.DOWN)
			crouch = true;
		else
			crouch = false;
		if (atacando)
		{
			if (direc)
			{
				if (crouch || salto)
					animation.play("attackCR");
				else
					animation.play("attackR");
			}
			else
			{
				if (crouch|| salto)
					animation.play("attackCL");
				else
					animation.play("attackL");
			}
		}
		else if (velocity.x == 0)
		{
			if (direc == true) 
			{
				if (crouch)
					animation.play("crouchR");
				else
					animation.play("idleR");
			}
			else 
			{
				if (crouch)
					animation.play("crouchL");
				else
					animation.play("idleL");
			}
		}
		if (x <= 0 && salto)
			velocity.x = 0;
		if (x > (Reg.tileWidth - width) && salto)
			velocity.x = 0;
		if (soundCounter == 15)
			soundCounter = 0;
	}
	public function invulEffect():Void
	{
		invulCounter++;
		invulEfectCounter++;
		if (invulEfectCounter == 10) 
		{
			visible = !visible;
			invulEfectCounter = 0;
		}
		if (invulCounter == 160) 
		{
			visible = true;
			invulEfectCounter = 0;
			invulCounter = 0;
			invulnerable = false;
		}		
	}
	public function daniar():Void
	{
		if (!invulnerable)
		{
			health -= 15;
			invulnerable = true;	
		}
	}
	public function getLaserAmmo():Int 
	{
		return laserAmmo;
	}
	public function setLaserAmmo(value:Int):Void
	{
		laserAmmo = value;
	}
	public function setContained(value:Bool):Void
	{
		contained = value;
	}
	public function atacar(value:Bool):Void
	{	
		atacando = value;
	}
}