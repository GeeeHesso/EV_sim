import numpy as np
import random
import matplotlib.pyplot as plt

# 97511 Dave
# 97583 Salah

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

        self.I=1000

        self.alpha=0
        self.omega=0
        self.theta=0
        

    def get_torque(self,speed,acc):
        
        '''
    mu  --------------̣-mu1
                         \
                          \
                           \
        ...................m0......................................
        \                  /
         \                /
          \              /
    md     \md1______md2/

        '''

        r_torque = 0
        if acc >= 0: # speeding UP
            r_torque = np.interp(speed,[0,self.mu1,self.m0],[self.mu,self.mu,0])

        if acc < 0: #speeding DOWN
            r_torque = np.interp(speed,[0,self.md1,self.md2,self.m0],[self.md,self.md,self.md,0])  


        return r_torque

    def update(self, dt,torque):
        self.alpha = torque/self.I - 0.00001*self.omega
        o_omega=self.omega
        self.omega = self.alpha*dt+self.omega
        self.theta = 0.5*self.alpha*dt**2+o_omega*dt+self.theta



if __name__ == '__main__':

    sim=Sim()

    dt=1

    a_signal=[]
    a_speed=[]
    a_pos=[]
    a_acc=[]
    a_work_1=[]
    a_work_2=[]
    t_max=-10

    time=0

    consign = 5000
    sim.omega = 0

    # k_P=1.5
    # k_I=0.00001
    # k_D=0

    k_P=0
    k_I=0
    k_D=0
    k_DD=100

    s_I=0
    
    p_e = 0
    p_ee=0

    for i in range(2000000):
        # if i == 100000:
        #     consign = 100
        # if i == 200000:
        #     consign = 140
        # if i == 400000:
        #     consign = 40
        # if i == 600000:
        #     consign = 0

        o_theta=sim.theta

        e = consign-sim.theta
        # e = consign-sim.omega
        s_P = e*k_P
        s_I = s_I + e*dt
        s_D = (e-p_e)/dt
        s_DD = (e-2*p_e+p_ee)/(dt*dt)
        p_ee=p_e
        p_e=e
        signal = s_P + s_I*k_I + s_D*k_D + s_DD*k_DD

        max_torque = sim.get_torque(abs(sim.omega),signal)

        if signal > 0 and signal > max_torque:
            signal = max_torque
        if signal < 0 and signal < max_torque:
            signal = max_torque

        a_signal.append(signal)
        sim.update(dt,signal)
        
        a_speed.append(sim.omega)
        a_pos.append(sim.theta)
        a_acc.append(sim.alpha)

        t=signal
        work1 = t*(sim.theta - o_theta)
        work2 = (t_max-t)*(sim.theta - o_theta)
        a_work_1.append(work1)
        a_work_2.append(work2)

        time +=1
        # if sim.omega < 0:
        #     print(time)
        #     break
            

    # tm_one=np.tril(np.ones(time),0)


    plt.plot(a_speed)
    plt.title('Speed')
    plt.figure()
    plt.plot(a_pos)
    plt.title('Pos')
    plt.figure()
    plt.plot(a_acc)
    plt.title('Acc')
    plt.figure()
    plt.plot(a_signal)
    plt.title('Signal')
    # plt.figure()
    # plt.plot(np.array(a_work_1)+np.array(a_work_2),'--')
    # plt.plot(a_work_1)
    # plt.plot(a_work_2)
    # plt.figure()
    # plt.plot(np.matmul(tm_one,a_work_1))
    # plt.plot(np.matmul(tm_one,a_work_2))
    # plt.plot(np.matmul(tm_one,a_work_2)+np.matmul(tm_one,a_work_1),'--')
    # plt.figure()
    # plt.plot(np.array(a_work_1)/(np.array(a_work_1)+np.array(a_work_2)))
    # plt.plot(np.array(a_work_2)/(np.array(a_work_1)+np.array(a_work_2)))
    plt.show()
