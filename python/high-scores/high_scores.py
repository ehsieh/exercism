class HighScores(object):
    def __init__(self, scores):
        self.scores = scores

    def latest(self):
        return self.scores[-1]

    def personal_best(self):
        return max(self.scores)
    
    def personal_top_three(self):        
        if len(self.scores) < 3:
            return sorted(self.scores, reverse=True)
            
        copy = sorted(self.scores)
        retval = []
        retval.append(copy.pop())
        retval.append(copy.pop())
        retval.append(copy.pop())
        return retval
        

