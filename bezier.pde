int nbPoints = 10; 
float constructorLineThickness = 0.5;

float t=0;
float increment = 0.001; 
int j=0; 
int frame = ceil(1/increment); 

PVector[][] points = new PVector[frame][frame];

PVector[] generateOnCircle(int i, float diameter){
  PVector[] p = new PVector[i];
  for(int k = 0; k<i; k++){
    PVector v = new PVector(cos(k * 2* PI/i) , -sin(k* 2*PI/i));
    v.mult(0.5*diameter);
    v.add(new PVector(width/2, height/2));
    p[k] = v;
  } 
  return p; 
}

PVector[] genTwoConsecPtsWithMinDist(int i, float d){
  PVector[] p = new PVector[i];
  
  for(int j=0; j<i; j++){
     if(j == 0){ 
       p[0] = new PVector(random(width/3,2*width/3), random(height/3, 2*height/3)); 
     }else{
         PVector pt = new PVector(random(width/3,2*width/3), random(height/3, 2*height/3));
         
         while(dist(pt.x,pt.y, p[j-1].x, p[j-1].y) <= d){
           pt = new PVector(random(width/3,2*width/3), random(height/3, 2*height/3));
         }
         
      
       p[j] = pt;
     }
  }
  return p;
}

PVector[] genAtRandom(int n){
  PVector[] p = new PVector[n];
  for(int i = 0; i<nbPoints; i++){
    p[i] = new PVector( random(width/3,2*width/3), random(height/3, 2*height/3) );
  }
  return p;
}

void setup(){
  fullScreen(1);
  points[0] = generateOnCircle(nbPoints, 800);
  //points[0] = genTwoConsecPtsWithMinDist(nbPoints, 400);
  //points[0] = genAtRandom(nbPoints);
}

void draw(){
  background(255);
  strokeWeight(constructorLineThickness);
  stroke(0);
  
  fill(0);

  t+=increment;
  j+=1;
  
  if(t>=1-increment){
    noLoop();
  } 

  for(int k=0; k<nbPoints-1; k++){
    
      for(int l=0;l<nbPoints-k-1; l++){
      
      line(points[k][l].x, points[k][l].y, points[k][l+1].x, points[k][l+1].y);
      
      ellipse(points[k][l].x, points[k][l].y, 5, 5);
      ellipse(points[k][l+1].x, points[k][l+1].y, 5, 5);
      
      float x = lerp(points[k][l].x, points[k][l+1].x, t);
      float y = lerp(points[k][l].y, points[k][l+1].y, t);
      
      PVector v = new PVector(x,y);
      
      points[k+1][l] = v;
      
    }
  }

  if(j<=frame){
    points[nbPoints-1][j-1] = points[nbPoints-1][0];
  }

  for(int i=1; i<j-2; i++){
    stroke(255,0,0);    
    strokeWeight(1);
    line(points[nbPoints-1][i].x, points[nbPoints-1][i].y,points[nbPoints-1][i+1].x, points[nbPoints-1][i+1].y);
  }
 
  
}