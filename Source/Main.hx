package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import openfl.Lib;
import Sys;

class Main extends Sprite {
	private var toasters:Array<Toaster>;
	private var toasts:Array<Toast>;
	private var spawnTimer:Timer;
	private var toastArg = '0';
	private var toastType:Int = 0;

	public function new() {
		super();

		evalArgs();

		toasters = [];
		toasts = [];

		spawnTimer = new Timer(500);
		spawnTimer.addEventListener(TimerEvent.TIMER, spawnToaster);
		spawnTimer.start();

		stage.addEventListener(Event.ENTER_FRAME, update);
	}

	private function evalArgs() {
		var args = Sys.args();
		var i = 0;
		while (i < args.length) {
			var arg = args[i];
			if (arg == "-h" || arg == "--help") {
				printHelp();
				Sys.exit(1);
			}

			if (arg == "-t" || arg == "--toast") {
				toastArg = args[i + 1];
				switch (toastArg) {
					case '0':
						toastType = 0;
					case '1':
						toastType = 1;
					case '2':
						toastType = 2;
					case '3':
						toastType = 3;
					default:
						trace("Error: " + arg + " must be either 0, 1, 2, or 3.");
						Sys.exit(0);
				}
			}

			i++;
		}
	}

	private function printHelp() {
		trace("Help message here.");
	}

	private function addToaster(posX:Float, posY:Float) {
		var toaster:Toaster = new Toaster();

		toaster.x = posX;
		toaster.y = posY;

		toasters.push(toaster);
		addChild(toaster);
	}

	private function addToast(posX:Float, posY:Float) {
		var toast:Toast = new Toast(toastType);

		toast.x = posX;
		toast.y = posY;

		toasts.push(toast);
		addChild(toast);
	}

	private function spawnToaster(e:TimerEvent) {
		var spawnOnTop = Math.random() > 0.5;

		var posX:Float;
		var posY:Float;

		if (spawnOnTop) {
			posX = Math.random() * stage.stageWidth;
			posY = -64;
		} else {
			posX = stage.stageWidth + 64;
			posY = Math.random() * stage.stageHeight;
		}

		var rand = Math.random();
		if (rand < 0.75) {
			addToaster(posX, posY);
		} else {
			addToast(posX, posY);
		}
	}

	private function update(e:Event) {
		var i = toasters.length - 1;
		while (i >= 0) {
			var toaster = toasters[i];

			toaster.x += -1 * toaster.speed;
			toaster.y += toaster.speed;

			if (toaster.x < -64 || toaster.y > stage.stageHeight + 64) {
				// trace("Removing toaster at position (" + toaster.x + ", " + toaster.y + ")");
				removeChild(toaster);
				toasters.splice(i, 1);
			}

			i--;
		}

		var i2 = toasts.length - 1;
		while (i2 >= 0) {
			var toast = toasts[i2];

			toast.x += -1 * toast.speed;
			toast.y += toast.speed;

			if (toast.x < -64 || toast.y > stage.stageHeight + 64) {
				// trace("Removing toast at position (" + toast.x + ", " + toast.y + ")");
				removeChild(toast);
				toasts.splice(i2, 1);
			}

			i2--;
		}
	}
}
