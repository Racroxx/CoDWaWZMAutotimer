// made by racroxx

state ("CoDWaW")
	{
		int roundNumber: 0x23E3FC , 0xFAC;
		int frame: 0x08EC44 , 0x0;
	}
	
	// start the timer if round had changed above 0
	start
	{
		if (current.roundNumber > 0){
			return true;
		}
	}
	
	// reset the timer if round has been reset back to 0
	reset
	{
		if (current.frame == 0){
			return true;
		}
	}