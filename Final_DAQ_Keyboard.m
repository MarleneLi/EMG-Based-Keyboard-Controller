clc; clear;

import java.awt.Robot;
robot = Robot;

a = arduino('Com6');

f = zeros(10,4);

while 1
     for ii = 1:10
         f(ii,1) = readVoltage(a,'A0');
         f(ii,2) = readVoltage(a,'A1');
         f(ii,3) = readVoltage(a,'A2');
         f(ii,4) = readVoltage(a,'A3');
     end
     
    left_arm_count = 0;
    right_arm_count = 0;
    left_leg_count = 0;
    right_leg_count = 0;
    
    for i = 1:size(f,1)-1
        if f(i,1)<0.05 && f(i+1,1)>=0.05
            left_arm_count = left_arm_count + 1;
        end
        if f(i,2)<0.05 && f(i+1,2)>=0.05
            right_arm_count = right_arm_count + 1;
        end
        if f(i,3)<0.05 && f(i+1,3)>=0.05
            left_leg_count = left_leg_count + 1;
        end
        if f(i,4)<0.05 && f(i+1,4)>=0.05
            right_leg_count = right_leg_count + 1;
        end
    end
    
    if left_arm_count > right_arm_count && ...
       left_arm_count > left_leg_count && ...
       left_arm_count > right_leg_count
   
        robot.keyPress(java.awt.event.KeyEvent.VK_S);
        robot.keyRelease(java.awt.event.KeyEvent.VK_S);
    elseif right_arm_count > left_arm_count && ...
       right_arm_count > left_leg_count && ...
       right_arm_count > right_leg_count
   
        robot.keyPress(java.awt.event.KeyEvent.VK_W);
        robot.keyRelease(java.awt.event.KeyEvent.VK_W);
    elseif left_leg_count > right_arm_count && ...
       left_leg_count > left_arm_count && ...
       left_leg_count > right_leg_count
   
        robot.keyPress(java.awt.event.KeyEvent.VK_A);
        robot.keyRelease(java.awt.event.KeyEvent.VK_A);
        
    elseif right_leg_count > right_arm_count && ...
       right_leg_count > left_leg_count && ...
       right_leg_count > left_arm_count
   
        robot.keyPress(java.awt.event.KeyEvent.VK_D);
        robot.keyRelease(java.awt.event.KeyEvent.VK_D);
        
    end
    
    subplot(2,2,1)
    plot(1:10,f(:,1))
    title('Left Arm (S)')
    subplot(2,2,2)
    plot(1:10,f(:,2))
    title('Right Arm (W)')
    subplot(2,2,3)
    plot(1:10,f(:,3))
    title('Left Leg (A)')
    subplot(2,2,4)
    plot(1:10,f(:,4))
    title('Right Leg (D)')
    
    
    disp(left_arm_count)
    disp(right_arm_count)
    disp(left_leg_count)
    disp(right_leg_count)
end

