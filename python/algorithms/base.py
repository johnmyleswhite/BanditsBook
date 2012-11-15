from abc import ABCMeta
import abc

class BanditAlgo(object):
    """
    This is a base class for all other bandit algorithms.
    """
    __metaclass__ = ABCMeta

    @staticmethod
    def ind_max(x):
        m = max(x)
        return x.index(m)

    def initialize(self, n_arms):
        self.counts = [0 for col in range(n_arms)]
        self.values = [0.0 for col in range(n_arms)]
        return

    @abc.abstractmethod
    def update(self):
        """
        A method to update the parameters of the specific
        bandit algorithm.
        """
        pass

    @abc.abstractmethod
    def select_arm(self):
        """
        A method to select an arm as determined by the specific
        bandit algorithm.
        """
        pass
