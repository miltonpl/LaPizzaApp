

class Bomb{
    constructor(x, y, w, h, img, speed){
        this.x = x;
        this.y = y;
		this.w = w;
		this.h = h;
		this.img = img;
		this.speed = speed;
        this.dir = 0;
        this.toDelete = false;
    }
	show(){
		image(this.img, this.x, this.y, this.w, this.h);
	}
	hits(object){
		//alien (x,y) bom (x,y)
		let d = dist(this.x, this.y, object.x, object.y);
		if((d < object.h || d < this.w) &&(object.x < this.x && this.x < object.x + object.w))
			return true;
		else
			return false;
    }
	hitFance(fance){
		// var d = dist(this.x, this.y, fance.x,fance.y);
		let y1 = this.y + this.h;
		let x1 = this.x + this.w;
		//bullete must be in  range of fance= {fance.x , fance.x+fance.w}
		if((this.x > fance.x && this.x < fance.x+ fance.w && y1 > fance.y && y1 < fance.y+fance.w)||
			(x1 > fance.x && x1 < fance.x+fance.w && y1 > fance.y && y1 < fance.y+fance.h)||
			(fance.x > this.x && fance.x < x1 && fance.y > this.y && fance.y <y1)){
				this.toDelete = true;
				return true;
			}
		else
		return false;
	}
	disapear(){
		this.toDelete= true;
    }
    setYDir(dir){
        this.dir = dir;
    }
	move(){
        if(this.dir > 0)
            this.y = this.y + this.speed;
        else if(this.dir < 0)
            this.y = this.y - this.speed;
	}
}