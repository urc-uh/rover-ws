import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Joy
from std_msgs.msg import Float32


class BasicDrive(Node):
    def __init__(self):
        super().__init__('basic_drive')
        self.declare_parameter('axis', 1)
        self.declare_parameter('invert', True)
        self.declare_parameter('deadzone', 0.05)
        self.pub = self.create_publisher(Float32, 'speed', 10)
        self.sub = self.create_subscription(Joy, 'joy', self.on_joy, 10)

    def on_joy(self, msg):
        axis = self.get_parameter('axis').value
        invert = self.get_parameter('invert').value
        deadzone = self.get_parameter('deadzone').value

        value = msg.axes[axis]
        if invert:
            value = -value
        if abs(value) < deadzone:
            value = 0.0

        out = Float32()
        out.data = float(value)
        self.pub.publish(out)


def main(args=None):
    rclpy.init(args=args)
    node = BasicDrive()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
