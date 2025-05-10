package;

import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

class Toast extends Sprite {
	public var speed:Float;
	public var toastType:Int;
	private var bitmapData:BitmapData;

	public function new(toastType:Int = 0) {
		this.toastType = toastType;

		super();

		var rand = Math.random();
		if (rand < 0.55) {
			speed = 1.5;
		} else if (rand < 0.76) {
			speed = 1;
		} else if (rand < 0.95) {
			speed = 2;
		} else {
			speed = 3;
		}

		if (toastType == 0) {
			bitmapData = Assets.getBitmapData("assets/toast0.png");
		} else if (toastType == 1) {
			bitmapData = Assets.getBitmapData("assets/toast1.png");
		} else if (toastType == 2) {
			bitmapData = Assets.getBitmapData("assets/toast2.png");
		} else {
			bitmapData = Assets.getBitmapData("assets/toast3.png");
		}

		var bitmap:Bitmap = new Bitmap(bitmapData);

		addChild(bitmap);
	}
}
