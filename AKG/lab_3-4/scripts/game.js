import { Player } from './player.js';
import { Bitmap } from './bitmap.js';
import { View } from './view.js';
import * as Util from './utils.js';
import * as Resources from './resources.js';
import { Constants } from './constants.js';

export class Game {
  constructor() {
    this.times = [];
    this.fps;

    this.started = false;

    this.cvs;
    this.tmpCvs;
    this.gfx;
    this.tmpGfx;

    this.frameCounterElement;

    this.pause = false;
    this.time = 0;

    this.view;

    this.keys = {};
    this.mouse = {
      down: false,
      lastX: 0.0,
      lastY: 0.0,
      currX: 0.0,
      currY: 0.0,
      dx: 0.0,
      dy: 0.0,
    };
    this.postprocessEnabled = [false, false, true, false, false];
  }

  start() {
    this.init();
    this.run();
  }

  init() {
    window.blurVal = 1;
    window.expose = 2;
    window.turn = true;
    this.cvs = document.getElementById('canvas');
    this.gfx = this.cvs.getContext('2d');
    this.gfx.font = '60px verdana';

    this.tmpCvs = document.createElement('canvas');
    this.tmpGfx = this.tmpCvs.getContext('2d');

    window.addEventListener(
      'mousedown',
      e => {
        if (e.button != 0) return;

        this.mouse.down = true;
      },
      false
    );
    window.addEventListener(
      'mouseup',
      e => {
        if (e.button != 0) return;

        this.mouse.down = false;
      },
      false
    );

    window.addEventListener('keydown', e => {
      if (e.key == 'Escape') this.pause = !this.pause;

      if (e.key == 'w' || e.key == 'ArrowUp') this.keys.up = true;
      if (e.key == 'a' || e.key == 'ArrowLeft') this.keys.left = true;
      if (e.key == 's' || e.key == 'ArrowDown') this.keys.down = true;
      if (e.key == 'd' || e.key == 'ArrowRight') this.keys.right = true;
      if (e.key == ' ') this.keys.space = true;
      if (e.key == 'c') this.keys.c = true;
      if (e.key == 'q') this.keys.q = true;
      if (e.key == 'e') this.keys.e = true;
      if (e.key == 'Shift') this.keys.shift = true;
    });

    window.addEventListener('keyup', e => {
      if (e.key == 'w' || e.key == 'ArrowUp') this.keys.up = false;
      if (e.key == 'a' || e.key == 'ArrowLeft') this.keys.left = false;
      if (e.key == 's' || e.key == 'ArrowDown') this.keys.down = false;
      if (e.key == 'd' || e.key == 'ArrowRight') this.keys.right = false;
      if (e.key == ' ') this.keys.space = false;
      if (e.key == 'c') this.keys.c = false;
      if (e.key == 'q') this.keys.q = false;
      if (e.key == 'e') this.keys.e = false;
      if (e.key == 'Shift') this.keys.shift = false;
    });

    window.addEventListener('mousemove', e => {
      this.mouse.currX = e.screenX;
      this.mouse.currY = e.screenY;
    });

    this.frameCounterElement = document.getElementById('frame_counter');

    Constants.WIDTH = Constants.WIDTH / Constants.SCALE;
    Constants.HEIGHT = Constants.HEIGHT / Constants.SCALE;

    this.player = new Player(this.keys, this.mouse);
    this.view = new View(Constants.WIDTH, Constants.HEIGHT, this.player);
    window.view = this.view;

    let sample = new Bitmap(64, 64);
    for (let i = 0; i < 64 * 64; i++) {
      const x = i % 64;
      const y = Util.int(i / 64);
      sample.pixels[i] = ((x << 6) % 0xff << 8) | (y << 6) % 0xff;
    }
    Resources.textures['sample0'] = sample;

    sample = new Bitmap(64, 64);
    sample.clear(0xff00ff);
    Resources.textures['sample1'] = sample;

    sample = new Bitmap(64, 64);
    sample.clear(0xffffff);
    Resources.textures['white'] = sample;

    sample = new Bitmap(64, 64);
    sample.clear(0x8080ff);
    Resources.textures['default_normal'] = sample;
  }

  run() {
    const now = performance.now();
    while (this.times.length > 0 && this.times[0] <= now - 1000)
      this.times.shift();

    const delta = (now - this.times[this.times.length - 1]) / 1000.0;

    this.times.push(now);
    this.fps = this.times.length;
    this.frameCounterElement.innerHTML = this.fps + 'fps';

    if (!this.started && Constants.loadedResources == Constants.resourceReady) {
      this.started = true;
      this.cvs.setAttribute('width', Constants.WIDTH * Constants.SCALE + 'px');
      this.cvs.setAttribute(
        'height',
        Constants.HEIGHT * Constants.SCALE + 'px'
      );
      this.tmpCvs.setAttribute(
        'width',
        Constants.WIDTH * Constants.SCALE + 'px'
      );
      this.tmpCvs.setAttribute(
        'height',
        Constants.HEIGHT * Constants.SCALE + 'px'
      );
      this.gfx.font = '48px verdana';
    }
    if (this.started && !this.pause) {
      this.update(delta);
      this.render();
      this.time += delta;
    } else if (this.pause) {
      this.gfx.fillText('PAUSE', 4, 40);
    }

    requestAnimationFrame(this.run.bind(this));
  }

  update(delta) {
    this.mouse.dx = this.mouse.currX - this.mouse.lastX;
    this.mouse.dy = this.mouse.currY - this.mouse.lastY;
    this.mouse.lastX = this.mouse.currX;
    this.mouse.lastY = this.mouse.currY;

    this.player.update(delta);
    this.view.update(delta);
  }

  render() {
    this.view.clear(0x808080);
    this.view.renderView();
    this.view.postProcess(this.postprocessEnabled);
    this.tmpGfx.putImageData(Util.convertBitmapToImageData(this.view), 0, 0);
    this.gfx.save();
    this.gfx.imageSmoothingEnabled = false;
    this.gfx.drawImage(this.tmpCvs, 0, 0);
    this.gfx.restore();
  }
}
