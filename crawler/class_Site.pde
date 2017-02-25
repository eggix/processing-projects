class Site{
    String name;
    
    Site child;
    int numChild = 0;
    Site next;
    
    Site(String name){
        this.name = name;
    }
    
    //looking for all "/wiki/" references on current site
    void deeper(){
        String[] page = loadStrings(url + name);
        for(String line : page){
            String[] list = split(line, '"');
            for(String s : list){
                if(s.length() >= 6 && s.substring(0,6).equals("/wiki/")){
                    String name = s.substring(6);
                    if(name.indexOf(":") == -1 && !name.equals(this.name) && !name.equals("Main_Page"))
                        addChild(new Site(name));
                }
            }
        }
    }
    
    void addChild(Site s){
        numChild++;
        if(child == null)
            child = s;
        else{
            Site current = child;
            while(current.next != null){
                current = current.next;
            }
            current.next = s;
        }
    }
    
    void cPrint(){
        print(name + ": ");
        Site current = child;
        while(current != null){
            print(current.name + ", ");
            current = current.next;
        }
        println();
    }
    
    void plot(){
        textSize(12);
        translate(width/2, height/2);
        int i = 0;
        int d = 0;
        Site current = child;
        while(current != null){
            if(i < numChild/2.0){
                textAlign(LEFT, CENTER);
                d = gap;
            }
            else{
                textAlign(RIGHT, CENTER);
                d = -gap;
            }
            float w = i*4*PI/(numChild+numChild%2);
            pushMatrix();
            translate((radius+d)*cos(w),-(radius+d)*sin(w));
            rotate(-w);
            text(current.toString(), 0, 0);
            popMatrix();
            i++;
            current = current.next;
        } 
    }
    
    void buildup(){
        textSize(12);
        int d = 0;
        int i = 0;
        Site current = child;
        while(i <= toDraw && current != null){
            if(i < start.numChild/2.0){
                textAlign(LEFT, CENTER);
                d = gap;
            }
            else{
                textAlign(RIGHT, CENTER);
                d = -gap;
            }
            float w = i*4*PI/(numChild+numChild%2);
            pushMatrix();
            translate((radius+d)*cos(w),-(radius+d)*sin(w));
            rotate(-w);
            text(current.toString(), 0, 0);
            popMatrix();
            
            current = current.next;
            i++;
        }
        if(toDraw <= start.numChild)
            toDraw += numChild/speed +1;
    }
    
    void select(){
        t = 0;
        int x = mouseX - width/2;
        int y = -mouseY + height/2;
        angle = atan2(y,x);
        if(angle < 0)
            angle += 2*PI;
        float r = sqrt(x*x+y*y);
        int i = int(angle/(4*PI)*numChild-0.5);
        Site current = child;
        if(r > radius){
            for(int j = 0; j <= i; j++)
                current = current.next;
        }
        else{
            for(int j = 0; j <= numChild/2+i; j++)
                current = current.next;
        }
        println("SELECTING");
        current.deeper();
        start = current;
        toDraw = 0;
    }
    
    String toString(){
        String[] words = split(name, '_');
        String res = "";
        for(String s : words)
            res += s + " ";
        return res;
    }
}