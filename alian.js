
class Alien{

    constructor(x, y, w, h, img, xdir, ydir){
        this.x = x*(w+1) + 50;
        this.y = y*(h+1) + 30;
        this.w = w;
        this.h = h;
        this.img = img;
        this.xdir = xdir; //3
        this.ydir = ydir; //5
        this.toDelete = false;
        this.countShots = 0;
    }
    show(){
        image(this.img, this.x, this.y, this.w, this.h);
    }
    blowup(){
        this.toDelete = true;
    }
    shiftDown(){
        this.xdir *= -1;
        this.y += this.ydir;
    }
    move(){
        this.x = this.x + this.xdir;
    }
    hits(ship){
        /*
        x0,y0           x2,y2
        ---------------------
        |                   |
        |                   |
        |                   |
        |                   |
        |                   |
        |                   |
        ---------------------
        x1,y1           x3,y3
        */
        let s = {
                x0 : ship.x,         y0 : ship.y, 
                x1 : ship.x,         y1 : ship.y+ ship.h,
                x2 : ship.x+ ship.w, y2 : ship.y,
                x3 : ship.x+ ship.w, y3 : ship.y+ ship.h
                };    
        let t = {
                x0 : this.x,         y0 : this.y, 
                x1 : this.x,         y1 : this.y+ this.h,
                x2 : this.x+ this.w, y2 : this.y,
                x3 : this.x+ this.w, y3 : this.y+ this.h
                };  

        if( (s.x0 > t.x0 && s.x0 < t.x2 && s.y0 > t.y0 && s.y0 < t.y1)||
            (s.x1 > t.x0 && s.x1 < t.x2 && s.y1 > t.y0 && s.y1 < t.y3)||
            (s.x2 > t.x0 && s.x2 < t.x2 && s.y2 > t.y0 && s.y2 < t.y3)||
            (s.x3 > t.x0 && s.x3 < t.x2 && s.y3 > t.y0 && s.y3 < t.y3)||

            (t.x0 > s.x0 && t.x0 < s.x2 && t.y0 > s.y0 && t.y0 < s.y1)||
            (t.x1 > s.x0 && t.x1 < s.x2 && t.y1 > s.y0 && t.y1 < s.y3)||
            (t.x2 > s.x0 && t.x2 < s.x2 && t.y2 > s.y0 && t.y2 < s.y3)||
            (t.x3 > s.x0 && t.x3 < s.x2 && t.y3 > s.y0 && t.y3 < s.y3)){
                return true;
        }
        else 
        return false;
    }
    moveInBroundry(){
        if(this.x < 0 || this.x > width - this.w){
            this.shiftDown();
            this.move();
        }
        else
            this.move();
    }
    //delete after shots alienship
    inpact(){
        this.countShots +=1;
        if(this.countShots >= 10)
            this.toDelete= true;
    }
   
}