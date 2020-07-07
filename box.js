class Box{
    constructor(i, j, w, h){
        this.i = i;
        this.j = j;
        this.x =  i*5 + 15;
        this.y = height-(j*5)-60;
        this.w = w;
        this.h = h;
        this.color = 255;
        this.toDelete = false;
    }
    show(){
        fill(this.color);
        // stroke(127, 63, 120);
        rectMode(CENTER)
        rect(this.x, this.y, this.w, this.h);
    }
    removeBlock(){
        this.toDelete = true;
    }
   
}