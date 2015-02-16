/**
 * Converted/butchered LIBUSB header to a D-Language interface
 *
 * Authors: Ross Lonstein <lonstein@brightboxcharge.com>
 * License: LGPL
 * Copyright: 2015, Brightbox, Inc.
 * See_Also: http://libusbx.org
 * Notes: Libusb itself is Copyright
 * $(UL
 *   $(LI 2001 Johannes Erdfelt <johannes@erdfelt.com>)
 *   $(LI 2007-2008 Daniel Drake <dsd@gentoo.org>)
 *   $(LI 2012 Pete Batard <pete@akeo.ie>)
 *   $(LI 2012 Nathan Hjelm <hjelmn@cs.unm.edu>) )
 *
 */

module structs;

import enums;

extern (C):

alias libusb_transfer_cb_fn = void function(libusb_transfer *transfer);

/**
 * A structure representing the standard USB device descriptor. This
 * descriptor is documented in section 9.6.1 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_device_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE LIBUSB_DT_DEVICE in this
     * context. */
    ubyte  bDescriptorType;

    /** USB specification release number in binary-coded decimal. A value of
     * 0x0200 indicates USB 2.0, 0x0110 indicates USB 1.1, etc. */
    ushort bcdUSB;

    /** USB-IF class code for the device. See \ref libusb_class_code. */
    ubyte  bDeviceClass;

    /** USB-IF subclass code for the device, qualified by the bDeviceClass
     * value */
    ubyte  bDeviceSubClass;

    /** USB-IF protocol code for the device, qualified by the bDeviceClass and
     * bDeviceSubClass values */
    ubyte  bDeviceProtocol;

    /** Maximum packet size for endpoint 0 */
    ubyte  bMaxPacketSize0;

    /** USB-IF vendor ID */
    ushort idVendor;

    /** USB-IF product ID */
    ushort idProduct;

    /** Device release number in binary-coded decimal */
    ushort bcdDevice;

    /** Index of string descriptor describing manufacturer */
    ubyte  iManufacturer;

    /** Index of string descriptor describing product */
    ubyte  iProduct;

    /** Index of string descriptor containing device serial number */
    ubyte  iSerialNumber;

    /** Number of possible configurations */
    ubyte  bNumConfigurations;
};

/**
 * A structure representing the standard USB endpoint descriptor. This
 * descriptor is documented in section 9.6.6 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_endpoint_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_ENDPOINT LIBUSB_DT_ENDPOINT in
     * this context. */
    ubyte  bDescriptorType;

    /** The address of the endpoint described by this descriptor. Bits 0:3 are
     * the endpoint number. Bits 4:6 are reserved. Bit 7 indicates direction,
     * see \ref libusb_endpoint_direction.
     */
    ubyte  bEndpointAddress;

    /** Attributes which apply to the endpoint when it is configured using
     * the bConfigurationValue. Bits 0:1 determine the transfer type and
     * correspond to \ref libusb_transfer_type. Bits 2:3 are only used for
     * isochronous endpoints and correspond to \ref libusb_iso_sync_type.
     * Bits 4:5 are also only used for isochronous endpoints and correspond to
     * \ref libusb_iso_usage_type. Bits 6:7 are reserved.
     */
    ubyte  bmAttributes;

    /** Maximum packet size this endpoint is capable of sending/receiving. */
    ushort wMaxPacketSize;

    /** Interval for polling endpoint for data transfers. */
    ubyte  bInterval;

    /** For audio devices only: the rate at which synchronization feedback
     * is provided. */
    ubyte  bRefresh;

    /** For audio devices only: the address if the synch endpoint */
    ubyte  bSynchAddress;

    /** Extra descriptors. If libusbx encounters unknown endpoint descriptors,
     * it will store them here, should you wish to parse them. */
    const char *extra;

    /** Length of the extra descriptors, in bytes. */
    int extra_length;
};

/**
 * A structure representing the standard USB interface descriptor. This
 * descriptor is documented in section 9.6.5 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_interface_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_INTERFACE LIBUSB_DT_INTERFACE
     * in this context. */
    ubyte  bDescriptorType;

    /** Number of this interface */
    ubyte  bInterfaceNumber;

    /** Value used to select this alternate setting for this interface */
    ubyte  bAlternateSetting;

    /** Number of endpoints used by this interface (excluding the control
     * endpoint). */
    ubyte  bNumEndpoints;

    /** USB-IF class code for this interface. See \ref libusb_class_code. */
    ubyte  bInterfaceClass;

    /** USB-IF subclass code for this interface, qualified by the
     * bInterfaceClass value */
    ubyte  bInterfaceSubClass;

    /** USB-IF protocol code for this interface, qualified by the
     * bInterfaceClass and bInterfaceSubClass values */
    ubyte  bInterfaceProtocol;

    /** Index of string descriptor describing this interface */
    ubyte  iInterface;

    /** Array of endpoint descriptors. This length of this array is determined
     * by the bNumEndpoints field. */
    const libusb_endpoint_descriptor *endpoint;

    /** Extra descriptors. If libusbx encounters unknown interface descriptors,
     * it will store them here, should you wish to parse them. */
    const char *extra;

    /** Length of the extra descriptors, in bytes. */
    int extra_length;
};

/**
 * A collection of alternate settings for a particular USB interface.
 */
struct libusb_interface {
  /** Array of interface descriptors. The length of this array is determined
   * by the num_altsetting field. */
  libusb_interface_descriptor *altsetting;

  /** The number of alternate settings that belong to this interface */
  int num_altsetting;
};


/**
 * A structure representing the standard USB configuration descriptor. This
 * descriptor is documented in section 9.6.3 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_config_descriptor {
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_CONFIG LIBUSB_DT_CONFIG
     * in this context. */
    ubyte  bDescriptorType;

    /** Total length of data returned for this configuration */
    ushort wTotalLength;

    /** Number of interfaces supported by this configuration */
    ubyte  bNumInterfaces;

    /** Identifier value for this configuration */
    ubyte  bConfigurationValue;

    /** Index of string descriptor describing this configuration */
    ubyte  iConfiguration;

    /** Configuration characteristics */
    ubyte  bmAttributes;

    /** Maximum power consumption of the USB device from this bus in this
     * configuration when the device is fully opreation. Expressed in units
     * of 2 mA. */
    ubyte  MaxPower;

    /** Array of interfaces supported by this configuration. The length of
     * this array is determined by the bNumInterfaces field. */
    const libusb_interface *iface; // REPLACE 'interface' keyword with 'iface'

    /** Extra descriptors. If libusbx encounters unknown configuration
     * descriptors, it will store them here, should you wish to parse them. */
    const char *extra;

    /** Length of the extra descriptors, in bytes. */
    int extra_length;
};

/**
 * A structure representing the superspeed endpoint companion
 * descriptor. This descriptor is documented in section 9.6.7 of
 * the USB 3.0 specification. All multiple-byte fields are represented in
 * host-endian format.
 */
struct libusb_ss_endpoint_companion_descriptor
{

    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_SS_ENDPOINT_COMPANION in
     * this context. */
    ubyte  bDescriptorType;


    /** The maximum number of packets the endpoint can send or
     *  recieve as part of a burst. */
    ubyte  bMaxBurst;

    /** In bulk EP: bits 4:0 represents the maximum number of
     *  streams the EP supports. In isochronous EP: bits 1:0
     *  represents the Mult - a zero based value that determines
     *  the maximum number of packets within a service interval  */
    ubyte  bmAttributes;

    /** The total number of bytes this EP will transfer every
     *  service interval. valid only for periodic EPs. */
    ushort wBytesPerInterval;
};

/**
 * A generic representation of a BOS Device Capability descriptor. It is
 * advised to check bDevCapabilityType and call the matching
 * libusb_get_*_descriptor function to get a structure fully matching the type.
 */
struct libusb_bos_dev_capability_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte bLength;
    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
     * LIBUSB_DT_DEVICE_CAPABILITY in this context. */
    ubyte bDescriptorType;
    /** Device Capability type */
    ubyte bDevCapabilityType;
    /** Device Capability data (bLength - 3 bytes) */
    ubyte dev_capability_data[];
};

/**
 * A structure representing the Binary Device Object Store (BOS) descriptor.
 * This descriptor is documented in section 9.6.2 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_bos_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_BOS LIBUSB_DT_BOS
     * in this context. */
    ubyte  bDescriptorType;

    /** Length of this descriptor and all of its sub descriptors */
    ushort wTotalLength;

    /** The number of separate device capability descriptors in
     * the BOS */
    ubyte  bNumDeviceCaps;

    /** bNumDeviceCap Device Capability Descriptors */
    libusb_bos_dev_capability_descriptor *dev_capability [];
};

/**
 * A structure representing the USB 2.0 Extension descriptor
 * This descriptor is documented in section 9.6.2.1 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_usb_2_0_extension_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
     * LIBUSB_DT_DEVICE_CAPABILITY in this context. */
    ubyte  bDescriptorType;

    /** Capability type. Will have value
     * \ref libusb_capability_type::LIBUSB_BT_USB_2_0_EXTENSION
     * LIBUSB_BT_USB_2_0_EXTENSION in this context. */
    ubyte  bDevCapabilityType;

    /** Bitmap encoding of supported device level features.
     * A value of one in a bit location indicates a feature is
     * supported; a value of zero indicates it is not supported.
     * See \ref libusb_usb_2_0_extension_attributes. */
    uint  bmAttributes;
};

/**
 * A structure representing the SuperSpeed USB Device Capability descriptor
 * This descriptor is documented in section 9.6.2.2 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 */
struct libusb_ss_usb_device_capability_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
     * LIBUSB_DT_DEVICE_CAPABILITY in this context. */
    ubyte  bDescriptorType;

    /** Capability type. Will have value
     * \ref libusb_capability_type::LIBUSB_BT_SS_USB_DEVICE_CAPABILITY
     * LIBUSB_BT_SS_USB_DEVICE_CAPABILITY in this context. */
    ubyte  bDevCapabilityType;

    /** Bitmap encoding of supported device level features.
     * A value of one in a bit location indicates a feature is
     * supported; a value of zero indicates it is not supported.
     * See \ref libusb_ss_usb_device_capability_attributes. */
    ubyte  bmAttributes;

    /** Bitmap encoding of the speed supported by this device when
     * operating in SuperSpeed mode. See \ref libusb_supported_speed. */
    ushort wSpeedSupported;

    /** The lowest speed at which all the functionality supported
     * by the device is available to the user. For example if the
     * device supports all its functionality when connected at
     * full speed and above then it sets this value to 1. */
    ubyte  bFunctionalitySupport;

    /** U1 Device Exit Latency. */
    ubyte  bU1DevExitLat;

    /** U2 Device Exit Latency. */
    ushort bU2DevExitLat;
};

/**
 * A structure representing the Container ID descriptor.
 * This descriptor is documented in section 9.6.2.3 of the USB 3.0 specification.
 * All multiple-byte fields, except UUIDs, are represented in host-endian format.
 */
struct libusb_container_id_descriptor
{
    /** Size of this descriptor (in bytes) */
    ubyte  bLength;

    /** Descriptor type. Will have value
     * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
     * LIBUSB_DT_DEVICE_CAPABILITY in this context. */
    ubyte  bDescriptorType;

    /** Capability type. Will have value
     * \ref libusb_capability_type::LIBUSB_BT_CONTAINER_ID
     * LIBUSB_BT_CONTAINER_ID in this context. */
    ubyte  bDevCapabilityType;

    /** Reserved field */
    ubyte bReserved;

    /** 128 bit UUID */
    ubyte  ContainerID[16];
};

/**
 * Setup packet for control transfers. */
struct libusb_control_setup
{
    /** Request type. Bits 0:4 determine recipient, see
     * \ref libusb_request_recipient. Bits 5:6 determine type, see
     * \ref libusb_request_type. Bit 7 determines data transfer direction, see
     * \ref libusb_endpoint_direction.
     */
    ubyte  bmRequestType;

    /** Request. If the type bits of bmRequestType are equal to
     * \ref libusb_request_type::LIBUSB_REQUEST_TYPE_STANDARD
     * "LIBUSB_REQUEST_TYPE_STANDARD" then this field refers to
     * \ref libusb_standard_request. For other cases, use of this field is
     * application-specific. */
    ubyte  bRequest;

    /** Value. Varies according to request */
    ushort wValue;

    /** Index. Varies according to request, typically used to pass an index
     * or offset */
    ushort wIndex;

    /** Number of bytes to transfer */
    ushort wLength;
};

/* libusbx */

struct libusb_context;
struct libusb_device;
struct libusb_device_handle;
struct libusb_hotplug_callback;

/**
 * Structure providing the version of the libusbx runtime
 */
struct libusb_version {
  const ushort major;   /** Library major version. */
  const ushort minor;   /** Library minor version. */
  const ushort micro;   /** Library micro version. */
  const ushort nano;    /** Library nano version. */
  const char *rc;       /** Library release candidate suffix string, e.g. "-rc4". */
  const char *describe; /** For ABI compatibility only. */
};


/**
 * Isochronous packet descriptor. */
struct libusb_iso_packet_descriptor
{
    /** Length of data to request in this packet */
    uint length;

    /** Amount of data that was actually transferred */
    uint actual_length;

    /** Status code for this packet */
    libusb_transfer_status status;
};

/**
 * The generic USB transfer structure. The user populates this structure and
 * then submits it in order to request a transfer. After the transfer has
 * completed, the library populates the transfer with the results and passes
 * it back to the user.
 */
struct libusb_transfer {
    /** Handle of the device that this transfer will be submitted to */
    libusb_device_handle *dev_handle;

    /** A bitwise OR combination of \ref libusb_transfer_flags. */
    ubyte flags;

    /** Address of the endpoint where this transfer will be sent. */
    char endpoint;

    /** Type of the endpoint from \ref libusb_transfer_type */
    char type;

    /** Timeout for this transfer in millseconds. A value of 0 indicates no
     * timeout. */
    uint timeout;

    /** The status of the transfer. Read-only, and only for use within
     * transfer callback function.
     *
     * If this is an isochronous transfer, this field may read COMPLETED even
     * if there were errors in the frames. Use the
     * \ref libusb_iso_packet_descriptor::status "status" field in each packet
     * to determine if errors occurred. */
    libusb_transfer_status status;

    /** Length of the data buffer */
    int length;

    /** Actual length of data that was transferred. Read-only, and only for
     * use within transfer callback function. Not valid for isochronous
     * endpoint transfers. */
    int actual_length;

    /** Callback function. This will be invoked when the transfer completes,
     * fails, or is cancelled. */
    libusb_transfer_cb_fn callback;

    /** User context data to pass to the callback function. */
    void *user_data;

    /** Data buffer */
    char *buffer;

    /** Number of isochronous packets. Only used for I/O with isochronous
     * endpoints. */
    int num_iso_packets;

    /** Isochronous packet descriptors, for isochronous transfers only. */
    libusb_iso_packet_descriptor iso_packet_desc[];
};


/**
 * File descriptor for polling
 */
struct libusb_pollfd
{
    /** Numeric file descriptor */
    int fd;

    /** Event flags to poll for from <poll.h>. POLLIN indicates that you
     * should monitor this file descriptor for becoming ready to read from,
     * and POLLOUT indicates that you should monitor this file descriptor for
     * nonblocking write readiness. */
    short events;
};

