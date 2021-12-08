import * as Resources from './resources.js';

export let Constants = {};
Constants.WIDTH = 800;
Constants.HEIGHT = (Constants.WIDTH / 4) * 3;
Constants.SCALE_INDEX = 2;
Constants.SCALE = 1;
Constants.FOV = Constants.HEIGHT / Constants.SCALE;
Constants.resourceReady = 5;
// Object.keys(Resources.textures).length + Object.keys(Resources.models).length;
Constants.loadedResources = 0;
Constants.globalAlpha = 255;
