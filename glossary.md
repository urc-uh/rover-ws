# Glossary of Terms

Unfortunately, many terms we use have different definitions in different contexts that overlap for us.
The lay, general software, ROS, and our team's meaning for the word "controller", for example, may all vary in subtle or not-so-subtle ways.
Thus, we have created a glossary of terms here that try to give every term or phrase _one_ meaning when used in context of our rover's software.
All documentation and naming conventions in code should follow this glossary.

Some words have too many definitions or are too easy to misunderstand and we will add adjectives and such to specify the different meanings.
In this case, if the less-specific word does not have its own specified definition, you can use this word in documentation given:
- The specific term is used first in the same context
- Using the shorter term makes the documentation easier to read
- It is clear that the nonspecific term is referring to the same thing as the earlier specific term

This is a living document that should be expanded or edited as necessary, but avoid making changes that would result in previous documentation not following the above rules if possible.
When such changes must be made, include edits that bring the documentation in line with this glossary in the same pull request.

### Firmware
In our codebase, firmware refers to code intended to be compiled and uploaded to a microcontroller.
Basically, firmware is code in the [embedded-ws](https://github.com/urc-uh/embedded-ws).
This isn't really accurate to the true definition, but for now it seems the easiest way to distinguish considering that is the current delineation of the firmware subteam's purview.

### Controller

#### ROS controller
ROS control controller or `ros2_control` controller are also appropriate.
Refers to an implementation that extends the `ros2_control::controller_interface::ControllerInterface` class or an instantiation of that implementation.
Be specific if the distinction between the implementation (class) or instantiation (object) is relevant to your usage.

#### Game controller
A handheld video game-style input device with joysticks, buttons, triggers, etc.
For example, a PlayStation Dual Shock or DualSense.
_Always_ refer to these as a "game controller".
Shortening to "controller" gets way too confusing and it will be easier to communicate if we get the whole team in this habit.

#### Hardware controller
A physical piece of hardware, e.g. motor controller.
