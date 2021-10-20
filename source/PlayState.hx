package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var swagWidth:Float = 160 * 0.7;
	var playerStrums:FlxTypedGroup<FlxSprite>;
	var strumLineNotes:FlxTypedGroup<FlxSprite>;
	var dadStrums:FlxTypedGroup<FlxSprite>;

	// var trailCheckBox:FlxUICheckBox = new FlxUICheckBox(0, 300, null, null, "Turn On The Trail", 200);
	var dadPosText:FlxText;
	var mouseActived:Bool = false;

	var playerPosText:FlxText;
	var craditText:FlxText;
	var helpText:FlxText;

	var dadSelectBoxGroup:FlxTypedGroup<FlxSprite>;
	var playerSelectBoxGroup:FlxTypedGroup<FlxSprite>;
	var curSelected:Int = 0;

	// var strumsTrail:FlxTrail;
	// var playerstrumsTrail:FlxTrail;

	override public function create()
	{
		super.create();

		playerStrums = new FlxTypedGroup<FlxSprite>();
		add(playerStrums);

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		dadStrums = new FlxTypedGroup<FlxSprite>();
		add(dadStrums);

		craditText = new FlxText();
		craditText.text = 'MADE BY LEGO';
		craditText.size = 64;
		craditText.scrollFactor.set();
		craditText.alignment = FlxTextAlign.CENTER;
		craditText.screenCenter();
		craditText.alpha = 0.3;
		add(craditText);

		helpText = new FlxText(0, 300);
		helpText.setFormat('assets/fontslol/BMJUA.ttf', 32, FlxColor.WHITE, FlxTextAlign.LEFT);
		helpText.font = 'assets/fontslol/BMJUA.ttf';
		helpText.text = '원하는 화살표를 클릭하고 방향키를 눌러 움직입니다.
		\nShift키로 더 빠르게 움직일 수 있습니다.
		\nCtrl + Z키로 리셋합니다.';
		add(helpText);

		dadPosText = new FlxText(0, 0, 0, "Left X: 0\nLeft Y: 0\nDown X: 0\nDown Y: 0\nUp X: 0\nUp Y: 0\nRight X: 0\nRight Y: 0", 16);
		add(dadPosText);
		playerPosText = new FlxText(FlxG.width - 130, 0, 0, "0 :Left X\n0 :Left Y\n0 :Down X\n0 :Down Y\n0 :Up X\n0 :Up Y\n0 :Right X\n0 :Right Y", 16);
		add(playerPosText);

		dadSelectBoxGroup = new FlxTypedGroup<FlxSprite>();
		add(dadSelectBoxGroup);

		playerSelectBoxGroup = new FlxTypedGroup<FlxSprite>();
		add(playerSelectBoxGroup);

		/*
			dadStrums.forEachAlive(function(lol:FlxSprite)
			{
				strumsTrail = new FlxTrail(lol, null, 10, 3, 0.5, 0.65);
				trailCheckBox.callback = function()
				{
					strumsTrail.visible = trailCheckBox.checked;
					trace('CHECK!');
				};

				add(strumsTrail);
			});

			playerStrums.forEachAlive(function(lol:FlxSprite)
			{
				playerstrumsTrail = new FlxTrail(lol, null, 10, 3, 0.5, 0.65);
				trailCheckBox.callback = function()
				{
					playerstrumsTrail.visible = trailCheckBox.checked;
					trace('CHECK!');
				};
			});

				var dad1:FlxTextFormat = new FlxTextFormat(FlxColor.PURPLE);
				var dad2:FlxTextFormat = new FlxTextFormat(FlxColor.BLUE);
				var dad3:FlxTextFormat = new FlxTextFormat(FlxColor.LIME);
				var dad4:FlxTextFormat = new FlxTextFormat(FlxColor.RED);

				var player1:FlxTextFormat = new FlxTextFormat(FlxColor.PURPLE);
				var player2:FlxTextFormat = new FlxTextFormat(FlxColor.BLUE);
				var player3:FlxTextFormat = new FlxTextFormat(FlxColor.LIME);
				var player4:FlxTextFormat = new FlxTextFormat(FlxColor.RED);

				dadPosText.addFormat(dad1, 0, 19);
				dadPosText.addFormat(dad2, 20, 39);
				dadPosText.addFormat(dad3, 40, 56);
				dadPosText.addFormat(dad4, 56, 78);

				playerPosText.addFormat(player1, 0, 19);
				playerPosText.addFormat(player2, 20, 39);
				playerPosText.addFormat(player3, 40, 56);
				playerPosText.addFormat(player4, 56, 78);
		 */

		createStrums(1);
		createStrums(0);
	}

	override public function update(elapsed:Float)
	{
		dadPosText.text = "Left X: "
			+ dadStrums.members[0].x + "\nLeft Y: " + dadStrums.members[0].y + "\nDown X: " + dadStrums.members[1].x + "\nDown Y: " + dadStrums.members[1].y +
				"\nUp X: " + dadStrums.members[2].x + "\nUp Y: " + dadStrums.members[2].y + "\nRight X: " + dadStrums.members[3].x + "\nRight Y: " +
				dadStrums.members[3].y;

		playerPosText.text = "Left X: "
			+ playerStrums.members[0].x + "\nLeft Y: " + playerStrums.members[0].y + "\nDown X: " + playerStrums.members[1].x + "\nDown Y: " +
				playerStrums.members[1].y + "\nUp X: " + playerStrums.members[2].x + "\nUp Y: " + playerStrums.members[2].y + "\nRight X: " +
					playerStrums.members[3].x + "\nRight Y: " + playerStrums.members[3].y;

		// hard coding lol
		if (FlxG.mouse.overlaps(dadSelectBoxGroup.members[0]))
		{
			dadSelectBoxGroup.members[0].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 1;
			}
		}
		else
		{
			dadSelectBoxGroup.members[0].visible = false;
		}

		if (FlxG.mouse.overlaps(dadSelectBoxGroup.members[1]))
		{
			dadSelectBoxGroup.members[1].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 2;
			}
		}
		else
		{
			dadSelectBoxGroup.members[1].visible = false;
		}

		if (FlxG.mouse.overlaps(dadSelectBoxGroup.members[2]))
		{
			dadSelectBoxGroup.members[2].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 3;
			}
		}
		else
		{
			dadSelectBoxGroup.members[2].visible = false;
		}

		if (FlxG.mouse.overlaps(dadSelectBoxGroup.members[3]))
		{
			dadSelectBoxGroup.members[3].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 4;
			}
		}
		else
		{
			dadSelectBoxGroup.members[3].visible = false;
		}

		if (FlxG.mouse.overlaps(playerSelectBoxGroup.members[0]))
		{
			playerSelectBoxGroup.members[0].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 5;
			}
		}
		else
		{
			playerSelectBoxGroup.members[0].visible = false;
		}

		if (FlxG.mouse.overlaps(playerSelectBoxGroup.members[1]))
		{
			playerSelectBoxGroup.members[1].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 6;
			}
		}
		else
		{
			playerSelectBoxGroup.members[1].visible = false;
		}

		if (FlxG.mouse.overlaps(playerSelectBoxGroup.members[2]))
		{
			playerSelectBoxGroup.members[2].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 7;
			}
		}
		else
		{
			playerSelectBoxGroup.members[2].visible = false;
		}

		if (FlxG.mouse.overlaps(playerSelectBoxGroup.members[3]))
		{
			playerSelectBoxGroup.members[3].visible = true;
			if (FlxG.mouse.justPressed)
			{
				curSelected = 8;
			}
		}
		else
		{
			playerSelectBoxGroup.members[3].visible = false;
		}

		playerSelectBoxGroup.members[0].x = playerStrums.members[0].x;
		playerSelectBoxGroup.members[1].x = playerStrums.members[1].x;
		playerSelectBoxGroup.members[2].x = playerStrums.members[2].x;
		playerSelectBoxGroup.members[3].x = playerStrums.members[3].x;

		dadSelectBoxGroup.members[0].x = dadStrums.members[0].x;
		dadSelectBoxGroup.members[1].x = dadStrums.members[1].x;
		dadSelectBoxGroup.members[2].x = dadStrums.members[2].x;
		dadSelectBoxGroup.members[3].x = dadStrums.members[3].x;

		playerSelectBoxGroup.members[0].y = playerStrums.members[0].y;
		playerSelectBoxGroup.members[1].y = playerStrums.members[1].y;
		playerSelectBoxGroup.members[2].y = playerStrums.members[2].y;
		playerSelectBoxGroup.members[3].y = playerStrums.members[3].y;

		dadSelectBoxGroup.members[0].y = dadStrums.members[0].y;
		dadSelectBoxGroup.members[1].y = dadStrums.members[1].y;
		dadSelectBoxGroup.members[2].y = dadStrums.members[2].y;
		dadSelectBoxGroup.members[3].y = dadStrums.members[3].y;

		var memberNumbers:Int = 0;

		switch (curSelected)
		{
			case 1: // Dad Arrows
				memberNumbers = 0;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 1;
					}
				}
			case 2:
				memberNumbers = 1;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 1;
					}
				}
			case 3:
				memberNumbers = 2;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 1;
					}
				}
			case 4:
				memberNumbers = 3;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						dadStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						dadStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						dadStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						dadStrums.members[memberNumbers].y += 1;
					}
				}
			case 5: // Player Arrows
				memberNumbers = 0;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 1;
					}
				}
			case 6:
				memberNumbers = 1;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 1;
					}
				}
			case 7:
				memberNumbers = 2;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 1;
					}
				}
			case 8:
				memberNumbers = 3;
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 10;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 10;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 10;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 10;
					}
				}
				else
				{
					if (FlxG.keys.pressed.LEFT)
					{
						playerStrums.members[memberNumbers].x -= 1;
					}
					if (FlxG.keys.pressed.RIGHT)
					{
						playerStrums.members[memberNumbers].x += 1;
					}
					if (FlxG.keys.pressed.UP)
					{
						playerStrums.members[memberNumbers].y -= 1;
					}
					if (FlxG.keys.pressed.DOWN)
					{
						playerStrums.members[memberNumbers].y += 1;
					}
				}
		}

		if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.Z)
		{
			trace('reset');
			resetArrowsProbably();
		}

		if (FlxG.keys.justPressed.A)
		{
			// im lazy
		}

		super.update(elapsed);
	}

	function createStrums(id:Int = 0)
	{
		for (i in 0...4)
		{
			var babyArrow:FlxSprite = new FlxSprite(0, 50);

			// FlxG.log.add(i);

			babyArrow.frames = FlxAtlasFrames.fromSparrow('assets/images/NOTE_assets.png', 'assets/images/NOTE_assets.xml');
			babyArrow.animation.addByPrefix('green', 'arrowUP');
			babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
			babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
			babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

			babyArrow.antialiasing = true;
			babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

			switch (Math.abs(i))
			{
				case 2:
					babyArrow.x += swagWidth * 2;
					babyArrow.animation.addByPrefix('static', 'arrowUP');
					babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 3:
					babyArrow.x += swagWidth * 3;
					babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
					babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
				case 1:
					babyArrow.x += swagWidth * 1;
					babyArrow.animation.addByPrefix('static', 'arrowDOWN');
					babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 0:
					babyArrow.x += swagWidth * 0;
					babyArrow.animation.addByPrefix('static', 'arrowLEFT');
					babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			babyArrow.y -= 10;
			babyArrow.alpha = 0;
			FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});

			babyArrow.ID = i;

			if (id == 1)
			{
				playerStrums.add(babyArrow);
			}
			if (id == 0)
			{
				dadStrums.add(babyArrow);
			}

			// why the fuck
			var widtharrow:Int = Std.int(babyArrow.width);

			var heightarrow:Int = Std.int(babyArrow.height);

			// now for the arrow box
			var babybox:FlxSprite = new FlxSprite(0, 50).makeGraphic(widtharrow, heightarrow, FlxColor.WHITE);

			switch (Math.abs(i))
			{
				case 0:
					babybox.x += swagWidth * 0;
					babybox.color = FlxColor.PURPLE;
				case 1:
					babybox.x += swagWidth * 1;
					babybox.color = FlxColor.BLUE;
				case 2:
					babybox.x += swagWidth * 2;
					babybox.color = FlxColor.LIME;
				case 3:
					babybox.x += swagWidth * 3;
					babybox.color = FlxColor.RED;
			}

			babybox.scrollFactor.set();

			babybox.ID = i;

			if (id == 1)
			{
				playerSelectBoxGroup.add(babybox);
			}
			if (id == 0)
			{
				dadSelectBoxGroup.add(babybox);
			}

			babybox.alpha = 0.5;
			babybox.visible = false;

			babybox.x += 50;
			babybox.x += ((FlxG.width / 2) * id);

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * id);

			strumLineNotes.add(babyArrow);
		}
	}

	function resetArrowsProbably():Void
	{
		playerStrums.forEachAlive(function(spr:FlxSprite)
		{
			switch (spr.ID)
			{
				case 0:
					spr.x = 690;
					spr.y = 50;
				case 1:
					spr.x = 802;
					spr.y = 50;
				case 2:
					spr.x = 914;
					spr.y = 50;
				case 3:
					spr.x = 1026;
					spr.y = 50;
			}
		});

		dadStrums.forEachAlive(function(spr:FlxSprite)
		{
			switch (spr.ID)
			{
				case 0:
					spr.x = 50;
					spr.y = 50;
				case 1:
					spr.x = 162;
					spr.y = 50;
				case 2:
					spr.x = 274;
					spr.y = 50;
				case 3:
					spr.x = 386;
					spr.y = 50;
			}
		});
	}
}
