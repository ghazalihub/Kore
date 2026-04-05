struct udev;
struct udev_device;
struct udev_enumerate;
struct udev_list_entry;
struct udev_monitor;
#define udev_list_entry_foreach(entry, first) for (entry = first; entry != NULL; entry = NULL)
