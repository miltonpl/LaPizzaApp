// Run this in the terminal
// python -m SimpleHTTPServer
// download pics
//https://www.uihere.com/free-cliparts/spacecraft-sprite-spaceshipone-computer-software-space-invaders-2016134
// 	ship = new Ship(img[3],40,40,10);
// var img=[];

let front;
let helper;
let count1={a:0};
let count2={a:0};
var ship;
var upbombs=[];
var downbombs=[];
let score = { ship : 0, alien : 0 };

var fance;
var aliens=[];
let alien2;
let alienb=[];
let soundShots;
let soundBackGround;
let soundShotAlien;
let alien2_created = false;
let bg=[];
let img;
let rand_bg=0;
let fance_={ cols : 80, rows : 10};
let prevScore=0
// var drop;
//sudo gem install rails export LDFLAGS="-L/usr/local/opt/ruby/lib" export CPPFLAGS="-I/usr/local/opt/ruby/include"
//runs only once
function preload(){
	
	soundShots = loadSound('sounds/gun_explosion.wav');
	soundShotAlien = loadSound('sounds/shoot_alien.wav');
	soundBackGround = loadSound('sounds/sound_intro_alien.wav');
	bg[0] = loadImage('images/background/background0.png');
	bg[1] = loadImage('images/background/background1.png');
	bg[2] = loadImage('images/background/background2.png');
	bg[3] = loadImage('images/background/background3.png');
	bg[4] = loadImage('images/background/background4.png');
	bg[5] = loadImage('images/background/background5.png');
	bg[6] = loadImage('images/background/background6.png');
	bg[7] = loadImage('images/background/background7.png');
	bg[8] = loadImage('images/background/background8.png');
	bg[9] = loadImage('images/background/background9.png');
	bg[10] = loadImage('images/background/background10.png');
	bg[11] = loadImage('images/background/background11.png');

}
function setup() {
	createCanvas(700, 600);
	helper = new Helper();
	img = helper.getImage();
	let ship_ = {w : 40, h : 40, img : img[3], xspeed : 5, yspeed : 5};
	ship= new Ship(ship_.img, ship_.w,ship_.h,ship_.xspeed, ship_.yspeed);
	resetSketch();
	var button = createButton("reset");
	button.mousePressed(resetSketch)
	
}
function resetSketch(){
	fance = helper.getFance(fance_.cols, fance_.rows);

	alien2 = helper.getAlien();
	rand_bg = floor(random(bg.length));
	aliens =helper.getAlienShips(10,3,3);
	score.alien = score.ship = 0;
}

function draw() {
	
	var edge= false;
	//new set of ships
	let dropbomb = helper.getCount(count1,50);
	let droprock = helper.getCount(count2,100);

	background(bg[rand_bg]);
	ship.show(); 
	ship.move();
	//drop rock
	textAlign(LEFT);
	text("Ship: "+score.ship+" Alien: "+score.alien,20,20);
	for (let i= 0; i < fance.length; i++) {
		for (let j= 0; j < fance[i].length; j++) {
			fance[i][j].show();
			//check if alien bomb hits the fance
			for (let k = 0; k < downbombs.length; k++) {
				if(downbombs[k].hitFance(fance[i][j])){
					fance[i][j].removeBlock();
					// console.log("remove block")
				}
			}
		}
	}
	//remove block from fance
	for (let i=  fance.length-1; i >= 0 ; i--) {
		for (let j = fance[i].length-1; j >= 0; j--) {
			if(fance[i][j].toDelete){
				fance[i].splice(j,1);
				score.alien++;
			}
		}
	}
	// if no alien then create new alien ship	
	if(helper.isEmpty(aliens))
		//rows = 21, colms = 3, blocks 3
		aliens =helper.getAlienShips(10,3,3);
	let index=[];
	for (let i = 0; i< aliens.length; i++) {
		for (let j = 0; j < aliens[i].length; j++){
			aliens[i][j].show();
			aliens[i][j].move();

			if(aliens[i][j] != undefined){
				index.push([i,j]);
				if(aliens[i][j].hits(ship)){
					// game over
					console.log("game over~~");
				}
			}
			
			if(aliens[i][j].x > width - aliens[i][j].w || aliens[i][j].x <= 0){
                edge = true;
                // console.log("hit edge");
			}
		}
	}
	//Drop bomb form alien ships randomly
	let randIndex = floor(random(index.length));
	let alien_index = index[randIndex];

	if(aliens[alien_index[0]][alien_index[1]]!= undefined && dropbomb){
		let i = alien_index[0];
		let j = alien_index[1];

		let b = new Bomb(aliens[i][j].x, aliens[i][j].y, 16, 16, img[2], 10);
		soundShotAlien.play();
		soundShotAlien.setVolume(0.05);
		b.setYDir(1);
		downbombs.push(b);
	}

	if(edge){//shiftdown alien ships
		for (let i = 0; i< aliens.length; i++) {
			for (let j = 0; j < aliens[i].length; j++)
				aliens[i][j].shiftDown();
		}
	}

	//bomb moving towards ship
	for (let i = 0; i < downbombs.length; i++){
		downbombs[i].show();
		downbombs[i].move();
		if(downbombs[i].hits(ship)){
			downbombs[i].disapear();
			ship.hit()
			score.ship--;
			console.log("Ship get hit!");
		}
	}
	//bomb hitting eachother!!
	for (let i = 0; i < downbombs.length; i++) {
	
		for (let j = 0; j < upbombs.length; j++) {
			if( downbombs[i].hits(upbombs[j]) ){
				downbombs[i].disapear();
				upbombs[j].disapear();
			}	
		}
	}
	//bomb moves toward aliens
	for (let k = 0; k < upbombs.length; k++) {
		upbombs[k].show();
		upbombs[k].move();
		for (let i = 0; i< aliens.length; i++) {
			for (let j = 0; j < aliens[i].length; j++)
				if(upbombs[k].hits(aliens[i][j])){
					//marked alienship to delete
	    			upbombs[k].disapear();
        			aliens[i][j].blowup();
	    	}
		}
	}
	
	//delete upbombs that hit the alien ship or passes the boundry
	for (var i =  upbombs.length-1; i >= 0; i--) {

			if(upbombs[i].toDelete ){
				// show explosion
				image(img[7],upbombs[i].x, upbombs[i].y,50,50);
				//delete
				upbombs.splice(i,1);
			}
			else if( upbombs[i].y < 0) //delete
				upbombs.splice(i,1);
		}
	//delete Alien shipship
	for (let i = aliens.length -1; i >= 0; i--) {
		for (let j = aliens[i].length-1; j >= 0; j--){
			if(aliens[i][j].toDelete){
				aliens[i].splice(j,1);
				score.ship++;
				//update score
			}
		}
	}
	//only create alien2 when all alien ships are doom
	if(helper.isEmpty(aliens)){
		alien2_created = true;
		// console.log("alien empty!");
	}
	//if alien2 is deleted create new alien2 and pick random background
	if(alien2.toDelete == true){
		alien2 = helper.getAlien();
		rand_bg = floor(random(bg.length));
	}
		
	//if alien2 exis show and move and play sound
	if(alien2_created){
		alien2.show();
		alien2.moveInBroundry();
		while(!soundBackGround.isPlaying())
			soundBackGround.play();
	}
	//drop rocks
	if(droprock && alien2_created){
		let b = new Bomb(alien2.x+alien2.w/3, alien2.y + alien2.h*(0.75), 32, 32, img[4], 8);
		b.setYDir(1);
		downbombs.push(b);
	}
	//mared bomb that hist the alien2 and mark alien
	for (let i = 0; i < upbombs.length; i++) {
		if(alien2_created && upbombs[i].hits(alien2)){
			upbombs[i].disapear();
			alien2.inpact();
			score.ship += 10;
		}
	}
	//delete alien if shot 10 times
	if(alien2.toDelete == true){
		delete alien2;
		alien2_created = false;
	}

	//delete bomb that is makered to be deleted
	for (let i = downbombs.length-1; i >= 0; i--) {
		if(downbombs[i].toDelete ) {
			//show explosion
			image(img[6],downbombs[i].x, downbombs[i].y,50,50);
			downbombs.splice(i,1);
		}	
		else if(downbombs[i].y > height)//dele if pass boundry
			downbombs.splice(i,1);
	}
}

function keyReleased(){
	 if(key != ' '){
		ship.setXDir(0);  
		ship.setYDir(0); 
	 }
}
//x === y return true if and only 
//if the two are identical and have the same data type.
function keyPressed(){
	if(key === ' '){
		// console.log("space pressed");
		soundShots.play();
		//volume range {0, 1};
		soundShots.setVolume(0.01);
        var d = new Bomb(ship.x + ship.w*0.3, ship.y, 16, 16, img[1], 10);
        d.setYDir(-1);
		upbombs.push(d);
	}
	if (keyCode === RIGHT_ARROW){
		ship.setXDir(1);
	}
	else if(keyCode === LEFT_ARROW){
		ship.setXDir(-1);
	}
	else if (keyCode === UP_ARROW){
		ship.setYDir(-1);
	}
	else if(keyCode === DOWN_ARROW){
		ship.setYDir(+1);
	}
}