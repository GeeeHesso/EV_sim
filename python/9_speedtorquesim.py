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
        self.omega=10
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

    
    energy_motor=[]
    energy_brake=[]
    t_max=-10

    


    for j in range(300):
        # j: speed
        sim.omega=j

        a_speed=[]
        a_pos=[]
        a_acc=[]
        a_work_1=[]
        a_work_2=[]

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
                # print(time)
                break
            
        energy_motor.append(np.sum(np.array(a_work_1)))
        energy_brake.append(np.sum(np.array(a_work_2)))



    plt.title('Absolute')
    plt.plot(energy_motor,label='electrical')
    plt.plot(energy_brake,label='mechanical')
    plt.legend()
    plt.figure()
    plt.title('Relative')
    plt.plot(np.array(energy_motor)/(np.array(energy_motor)+np.array(energy_brake)),label='electrical')
    plt.plot(np.array(energy_brake)/(np.array(energy_motor)+np.array(energy_brake)),label='mechanical')
    plt.legend()
    plt.show()
    
