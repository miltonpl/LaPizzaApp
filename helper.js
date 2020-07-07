

function isEmpty(array) {
    return Array.isArray(array) && (array.length == 0 || array.every(isEmpty));
  }
//2D array
class Helper{

    //get 2D array
    get2DArray(cols,rows){
        var arr = new Array(cols);
        for (var i = 0; i< arr.length; i++) {  
                arr[i]= new Array(rows);
        }
        return arr;
    }
    //if array is emtry return true else false
    isEmpty(array) {
        return isEmpty(array);
    }
    explotion(x, y, w, h, img){
        image(img,x ,y, w, h)
    }
    getImage(){
        let img=[];
            img[0] = loadImage('images/aliens/alien2.png');
            img[1] = loadImage('images/weapons/bullet_up.png');
            img[2] = loadImage('images/weapons/bullet_down.png');
            img[3] = loadImage('images/spaceship.png');
            img[4] = loadImage('images/weapons/rock.png');
            img[5] = loadImage('images/aliens/alien1.png');
            img[6] = loadImage('images/weapons/explotion.png');
            img[7] = loadImage('images/weapons/explotion2.png');
        return img;
    }
    //alien2 designedå
    getAlien(){
        let alien2_ = {w : 80, h : 80, img : img[5], speed : 10, xdir: 3, ydir: 5};
        return new Alien(2,0,alien2_.w, alien2_.h, alien2_.img,alien2_.xdir, alien2_.ydir);
    
    }
        
    getCount(count, upto){
        count.a++;
        if(count.a % upto == 0){
            count.a = 0;
            return true;
        }
        return false;
    }
    getAlienShips(cols,rows,blocks){
        //  var ships = make2DArray(cols,rows);
        //floor round to the nearest number close to zero ex.  the fllor of 23.70  is  23
        let ships = this.get2DArray(cols,rows);
        let alien1_ = {w : 28, h : 28, img : img[0], speed : 10, xdir: 3, ydir: 10};

        for (let i = 0; i< cols; i++) {
            for (let j = 0; j < rows; j++){

                if(i < floor(cols/blocks))
                    ships[i][j]= new Alien(i, j, alien1_.w, alien1_.h, alien1_.img,alien1_.xdir, alien1_.ydir);	
                else if(i >= floor(cols/blocks) && i < 2*floor(cols/blocks))	
                    ships[i][j]= new Alien(i+0.5 ,j ,alien1_.w, alien1_.h, alien1_.img,alien1_.xdir, alien1_.ydir);
                else 
                    ships[i][j]= new Alien(i+1, j, alien1_.w, alien1_.h, alien1_.img,alien1_.xdir, alien1_.ydir);
            }	
        }
        return ships;
    }
    getFance(cols, rows){
        // Dimestions of the fance blocks
        let d_ ={w : 5, h : 5};
        let dist = width/cols;
        fance = this.get2DArray(cols,rows);
        for (let i = 0; i< cols; i++) {
            for (let j = 0; j < rows; j++){
                if(i < 20)
                    fance[i][j]= new Box(i, j, d_.w, d_.h);	
                else if(i >= 20 && i < 40)	
                    fance[i][j]= new Box(i+dist, j,d_.w, d_.h);
                else if(i >= 40 && i < 60)	
                    fance[i][j]= new Box(i+dist*2,j, d_.w, d_.h);
                else	
                    fance[i][j]= new Box(i+dist*3,j ,d_.w, d_.h);
            }	
        }
        return fance;
    }
}