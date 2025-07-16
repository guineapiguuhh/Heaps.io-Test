import hxd.Res;
import h2d.Object;
import h2d.Bitmap;
import h2d.Text;
import hxd.res.DefaultFont;
import hxd.App;
import h2d.col.Point;
import hxd.Key;
import h2d.col.RoundRect;

class Main extends App 
{
	var haxeObj:Object;
	var haxeBitmap:Bitmap;

	var haxeVelocityX:Float = 0;
	var haxeVelocityY:Float = 0;

	var scoreTxt:Text;
	var score:Int = 0;

	static var maxTime:Int = 1000;
	var timeTxt:Text;
	var time:Int = maxTime;
	var updateTime:Bool = false;

	static var gameWidth:Float = 1366;
	static var gameHeight:Float = 768;

	var hardMode(default, set):Bool = false;

	function set_hardMode(v:Bool):Bool
	{
		hardMode = v;
		scoreTxt.textColor = hardMode ? 0xFF0000 : 0xFFFFFF;
		if (!hardMode) haxeVelocityX = haxeVelocityY = 0;
		return hardMode;
	}

	function reset()
	{
		score = 0;
		scoreTxt.text = "Score: -";
		timeTxt.text = "Time left: -";
		time = maxTime;
		updateTime = false;
		hardMode = false;

		haxeObj.x = gameWidth/2;
		haxeObj.y = gameHeight/2;
	}

	override function init() 
	{
		haxeObj = new Object(s2d);
		var tile = Res.images.hxlogo.toTile();
		tile = tile.center();
		haxeBitmap = new Bitmap(tile, haxeObj);

		scoreTxt = new Text(DefaultFont.get(), s2d);
		scoreTxt.x = gameWidth/2;
		scoreTxt.textAlign = Center;
		scoreTxt.scale(3.5);

		timeTxt = new Text(DefaultFont.get(), s2d);
		timeTxt.scale(2.5);

		reset();
	}

	override function update(dt:Float) 
	{
		if (updateTime)
		{
			time--;
			timeTxt.text = "Time left: " + time;
			if (time <= 0) reset();
		}
		updateHaxeObj(dt);
	}

	function updateHaxeObj(dt:Float) 
	{
		var objHitbox = new RoundRect(haxeObj.x, haxeObj.y, 228, 228, haxeObj.rotation);
		var mousePos = new Point(s2d.mouseX, s2d.mouseY);

		if (haxeObj.scaleX != 1) haxeObj.setScale(hxd.Math.lerp(haxeObj.scaleX, 1, 6 * dt));

		if (objHitbox.inside(mousePos)) 
		{
			haxeObj.alpha = 1;
			if (Key.isPressed(Key.MOUSE_LEFT)) 
			{
				haxeObj.setScale(0.9);
				haxeObj.x = hxd.Math.random(gameWidth);
				haxeObj.y = hxd.Math.random(gameHeight);

				scoreTxt.text = "Score: " + score;
				score++;
				time = maxTime;
				updateTime = true;

				hardMode = score >= 25;
			}
		} 
		else haxeObj.alpha = 0.6;

		if (hardMode)
		{
			haxeObj.x += haxeVelocityX*dt;
			haxeObj.y += haxeVelocityY*dt;

			if (haxeObj.x >= gameWidth || haxeObj.x <= 0) haxeVelocityX *= -1;
			if (haxeObj.y >= gameHeight || haxeObj.y <= 0) haxeVelocityY *= -1;
		}
	}

	static function main() 
	{
		Res.initEmbed();
		new Main();
	}
}
