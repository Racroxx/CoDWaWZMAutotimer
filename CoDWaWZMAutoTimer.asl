// made by racroxx

state ("CoDWaW")
	{
		int roundNumber: 0x23E3FC , 0xFAC;
		int timer: 0x08EC44 , 0x0;
		int game_paused: 0x1BBA94 , 0x0;
	}
	
	state ("plutonium-bootstrapper-win32")
	{
		int roundNumber: 0x23E3FC , 0xFAC;
		int timer: 0x08EC44 , 0x0;
		int game_paused: 0x1BBA94 , 0x0;
	}
	
	startup
{

    vars.timerModel = new TimerModel { CurrentState = timer };
	vars.is_paused = (vars.timerModel.CurrentState.CurrentPhase == TimerPhase.Paused);
	vars.timer_started = (vars.timerModel.CurrentState.CurrentPhase != TimerPhase.NotRunning);
	vars.timer_value = 0;
	vars.timer_pause_length = 0;
}

	// start the timer if round has changed above 0
	start
{
	vars.timer_started = true;
	if (current.roundNumber > 0)
		{	
			
			return true;
		}
}
	
	// reset the timer if timer has been reset back to 0
	reset
	{
		if (current.timer == 0){
			return true;
		}
	}
	
	//checks if the menu screen count is above 0 or not and pauses if it is above 0
	update
{	
	if (current.game_paused > 0 && !vars.is_paused) {
		vars.is_paused = true;
			
		if (vars.timer_started)
			vars.timerModel.Pause();
	}
	
	else if (current.game_paused == 0 && vars.is_paused){	
			vars.is_paused = false;
			
		if (vars.timer_started)
			vars.timerModel.Pause();
	}
	
	// in-game timer made by 5and5 (https://github.com//LiveSplitAutoSplitterForBlackOpsZombies)
	// we have our own timer that is basically the ingame timer that pauses when the player pauses the game
	// we do this so the player can pause the game when spawning in and the timer hasnt started yet.
	if (!vars.is_paused)
	{
		vars.timer_value = current.timer - vars.timer_pause_length;
	}
	else
	{
		vars.timer_pause_length = current.timer - vars.timer_value;
	}
	
	return true;
}