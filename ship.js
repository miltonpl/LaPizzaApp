class Ship{
    constructor(img,w,h,xspeed,yspeed){
        this.x = width/2;
        this.y= height - h*1.2;
        this.img = img;
        this.w = w;
        this.h = h;
        this.xspeed = xspeed;
        this.yspeed = yspeed;
        this.xdir = 0;
        this.ydir = 0;
        this.countShots=0;
    }
    show(){
        image(this.img, this.x, this.y, this.w, this.h);
    }
    setXDir(dir){
        this.xdir = dir;
    }
    setYDir(dir){
        this.ydir = dir;
    }
    hit(){
        this.countShots += 1;
        if(this.countShots >= 3){
            // end game
            console.log("Game Over :(");
        }
    }
    move(){
        if (this.x < 0) 
			this.x = 0;	
		else if(this.x > width-this.w)
            this.x = width-this.w;
        else if(this.y < 0)
            this.y = 0;
        else if(this.y > height - this.h)
            this.y = height - this.h;
        else{
            this.x += this.xdir*this.xspeed;
            this.y += this.ydir*this.yspeed;

        }
            

    }
}