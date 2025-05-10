package;

import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.display.Sprite;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import openfl.Assets;
import openfl.geom.Rectangle;

class Toaster extends Sprite {
	private var tilemap:Tilemap;
	private var tileset:Tileset;
	private var frames:Array<Int> = [0, 1, 2, 3, 2, 1];
	private var frameIndex:Int = 0;
	private var animationTimer:Timer;
	private var tile:Tile;
	public var speed:Float;
	private var frameTime:Int;

	public function new() {
		super();

		var rand = Math.random();
		if (rand < 0.55) {
			speed = 1.5;
			frameTime = 120;
		} else if (rand < 0.75) {
			speed = 1;
			frameTime = 150;
		} else if (rand < 0.95) {
			speed = 2;
			frameTime = 100;
		} else {
			speed = 3;
			frameTime = 75;
		}

		// Load sprite sheet
		tileset = new Tileset(Assets.getBitmapData("assets/toaster.png"));

		// Define each frame as a 64x64 rectangle
		for (i in 0...4) {
			tileset.addRect(new Rectangle(i * 64, 0, 64, 64));
		}

		// Create a Tilemap for rendering the sprite animation
		tilemap = new Tilemap(64, 64, tileset);
		addChild(tilemap);

		// Create a tile and add it to the tilemap
		tile = new Tile(frames[frameIndex], 0, 0);
		tilemap.addTile(tile);

		// Set up animation timer
		animationTimer = new Timer(frameTime);
		animationTimer.addEventListener(TimerEvent.TIMER, updateAnimation);
		animationTimer.start();
	}

	private function updateAnimation(e:TimerEvent):Void {
		frameIndex = (frameIndex + 1) % frames.length;
		tile.id = frames[frameIndex]; // Update tile index for animation
	}
}
