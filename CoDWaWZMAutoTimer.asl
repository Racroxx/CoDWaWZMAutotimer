// made by racroxx

state ("CoDWaW")
	{
		int frame: 0x08EC44 , 0x0;
		int entitysnapshots: 0x62F588 , 0x0;
	}
	
startup {
	if (timer.CurrentTimingMethod == TimingMethod.RealTime) // stolen from dude simulator 3, basically asks the runner to set their livesplit to game time
        {        
        var timingMessage = MessageBox.Show (
               "This game uses Time without Loads (Game Time) as the main timing method.\n"+
                "LiveSplit is currently set to show Real Time (RTA).\n"+
                "Would you like to set the timing method to Game Time? This will make verification easier",
                "LiveSplit | Call of Duty: World at War",
               MessageBoxButtons.YesNo,MessageBoxIcon.Question
            );
        
            if (timingMessage == DialogResult.Yes)
            {
                timer.CurrentTimingMethod = TimingMethod.GameTime;
            }
        }	
}
	// start the timer if entity snapshots has changed above 0
	start
	{
		if (current.entitysnapshots > 0){
			return true;
		}
	}
	
	// reset the timer if entity snapshots has been reset back to 0
	reset
	{
		if (current.entitysnapshots < old.entitysnapshots){
			return true;
		}
	}
	
	// check if the game is paused using the frame address
	isLoading
	{
		if (current.frame == old.frame){
			return true;
		}  else {
			return false;
		}
	}
	
	// fixes the timer and makes it accurate for game time in livesplit
	gameTime
	{
		if (current.frame > old.frame){
			// stolen gametime conversion from the BO2 synchronized livesplit (https://github.com/HuthTV/BO2-ZM-Synchronized-Livesplit)
			return TimeSpan.FromMilliseconds(current.frame - vars.startFrame);
		}
	}