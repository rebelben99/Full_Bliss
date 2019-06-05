if(Teleport.visible == true){	
	with(other){
		instance_destroy();	
	}
	if(room == Endscreen){
		room = Startscreen;	
	} else { 
		room_goto_next();
	}
}