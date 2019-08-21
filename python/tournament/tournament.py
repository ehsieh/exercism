class Team():
    def __init__(self, name):
        self.name = name
        self.played = 0
        self.wins = 0
        self.draws = 0
        self.losses = 0    
        self.points = 0

    def take_win(self):
        self.played += 1
        self.wins += 1
        self.points += 3

    def take_loss(self):
        self.played += 1
        self.losses += 1
      
    def take_draw(self):
        self.played += 1
        self.draws += 1
        self.points += 1

    def __lt__(self, other):
        if self.points == other.points:
            return self.name > other.name
        return self.points < other.points

    def __repr__(self):
        # Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
        return '{:<30} |  {} |  {} |  {} |  {} |  {}'.format(self.name, self.played, self.wins, self.draws, self.losses, self.points)

def tally(tournament_results):    
    team_results = {}
    print_result = 'Team                           | MP |  W |  D |  L |  P'
    
    if (tournament_results == ''):
        return print_result

    for game_result in tournament_results.split('\n'):
        team1, team2, result = game_result.split(';')        
        
        if team1 not in team_results.keys():
            team_results[team1] = Team(team1)
        if team2 not in team_results.keys():
            team_results[team2] = Team(team2)

        if (result == 'win'):
            team_results[team1].take_win()
            team_results[team2].take_loss()
        elif (result == 'loss'):
            team_results[team1].take_loss()
            team_results[team2].take_win()
        elif (result == 'draw'):
            team_results[team1].take_draw()
            team_results[team2].take_draw()
    sortedResults = sorted(team_results.values(), reverse=True)    
    
    for team in sortedResults:
        print_result += '\n' +  str(team)
    print(print_result)
    return print_result
