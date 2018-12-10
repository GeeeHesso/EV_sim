import numpy as np
import random
import matplotlib.pyplot as plt


class Sim(object):
    """docstring for Sim"""
    def __init__(self, mu=10,md=-10,mu1=100,md1=10,md2=100,m0=150):
        super(Sim, self).__init__()
        self.mu=mu       #[N/m]
        self.md=md       #[N/m]
        self.mu1=mu1     #[m/s]
        self.md1=md1     #[m/s]
        self.md2=md2     #[m/s]
        self.m0=m0       #[m/s]

        self.I=100

        self.alpha=0
        self.omega=150
        self.theta=0
        

    def get_torque(self,speed,acc):
        
        '''
    mu  ---------------mu1
                         \
                          \
                           \
        ...................m0......................................
        \                  /
         \                /
          \              /
    md     \md1------md2/

        '''

        r_torque = 0
        if acc > 0: # speeding UP
            r_torque = np.interp(speed,[0,self.mu1,self.m0],[self.mu,self.mu,0])

        if acc < 0: #speeding DOWN
            r_torque = np.interp(speed,[0,self.md1,self.md2,self.m0],[0,self.md,self.md,0])  


        return r_torque

    def update(self, dt,torque):
        self.alpha = torque/self.I
        o_omega=self.omega
        self.omega = self.alpha*dt+self.omega
        self.theta = 0.5*self.alpha*dt**2+o_omega*dt+self.theta



if __name__ == '__main__':

    sim=Sim()

    dt=1

    a_speed=[]
    a_pos=[]
    a_acc=[]
    a_work_1=[]
    a_work_2=[]
    t_max=-10

    time=0

    for i in range(100000):
        o_theta=sim.theta
        t=sim.get_torque(sim.omega,-1)
        sim.update(dt,t_max)
        a_speed.append(sim.omega)
        a_pos.append(sim.theta)
        a_acc.append(sim.alpha)

        work1 = t*(sim.theta - o_theta)
        work2 = (t_max-t)*(sim.theta - o_theta)
        a_work_1.append(work1)
        a_work_2.append(work2)

        time +=1
        if sim.omega < 0:
            print(time)
            break
            

    tm_one=np.tril(np.ones(time),0)


    plt.plot(a_speed)
    plt.figure()
    plt.plot(a_pos)
    plt.figure()
    plt.plot(a_acc)
    plt.figure()
    plt.plot(np.array(a_work_1)+np.array(a_work_2),'--')
    plt.plot(a_work_1)
    plt.plot(a_work_2)
    plt.figure()
    plt.plot(np.matmul(tm_one,a_work_1))
    plt.plot(np.matmul(tm_one,a_work_2))
    plt.plot(np.matmul(tm_one,a_work_2)+np.matmul(tm_one,a_work_1),'--')
    plt.figure()
    plt.plot(np.array(a_work_1)/(np.array(a_work_1)+np.array(a_work_2)))
    plt.plot(np.array(a_work_2)/(np.array(a_work_1)+np.array(a_work_2)))
    plt.show()
