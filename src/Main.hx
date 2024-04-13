import hxd.Res;
import h2d.Object;
import h2d.Bitmap;
import h2d.Text;
import hxd.res.DefaultFont;
import hxd.App;
// import h2d.Interactive;
import h2d.col.Point;
import hxd.Key;
import h2d.col.RoundRect;

class Main extends App {
	var obj:Object;
	var debugTxt:Text;

	var score:Int = 0;

	static var maxTime:Int = 200;

	var time:Int = maxTime;

	override function init() {
		debugTxt = new Text(DefaultFont.get());
		debugTxt.scale(5);
		debugTxt.text = "Score: 0";
		debugTxt.text += '\nTime: 0';

		obj = new Object(s2d);
		obj.x = 600;
		obj.y = 600;
		obj.alpha = 0.6;

		var tile = Res.images.hxlogo.toTile();
		tile = tile.center();
		var mybitmap = new Bitmap(tile, obj);

		// i hate you 😡!
		/*
			var haxeThing = new Interactive(200, 200, obj);
			haxeThing.onOver = function(event:hxd.Event) {
				obj.alpha = 1;
			}
			haxeThing.onOut = function(event:hxd.Event) {
				obj.alpha = 0.6;
			}
			haxeThing.onClick = function(event:hxd.Event) {
				score++;
				debugTxt.text = "Score: " + score;
				obj.setScale(1.5);
				obj.x = hxd.Math.random(1280);
				obj.y = hxd.Math.random(1080);
			}
		 */

		s2d.addChild(debugTxt);
	}

	override function update(dt:Float) {
		debugTxt.textColor = score >= 50 ? 0xFF0000 : 0xFFFFFF;

		var shit = new RoundRect(obj.x, obj.y, 300, 300, obj.rotation);
		var mousething = new Point(s2d.mouseX, s2d.mouseY);

		time--;
		if (shit.inside(mousething)) {
			obj.alpha = 1;
			if (Key.isReleased(Key.MOUSE_LEFT)) {
				score++;
				obj.setScale(1.5);
				obj.x = hxd.Math.random(980); // screen shit - width i think
				obj.y = hxd.Math.random(780); // screen fortnine - height i think
				if (maxTime <= 50) {
					maxTime -= 5
				}
				time = maxTime;
			}
		} else {
			obj.alpha = 0.6;
		}

		if (obj.scaleX != 1)
			obj.setScale(hxd.Math.lerp(obj.scaleX, 1, 0.2));

		if (time < 0) {
			score = hxd.Math.floor(score / 1.5);
			if (maxTime <= 50)
				maxTime = hxd.Math.floor(maxTime / 1.2);
			time = maxTime;
		}

		debugTxt.text = "Score: " + score;
		debugTxt.text += '\nTime: ' + time;
	}

	static function main() {
		Res.initEmbed();
		new Main();
	}
}
