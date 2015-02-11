/*
 * Public libusbx header file
 * Copyright © 2001 Johannes Erdfelt <johannes@erdfelt.com>
 * Copyright © 2007-2008 Daniel Drake <dsd@gentoo.org>
 * Copyright © 2012 Pete Batard <pete@akeo.ie>
 * Copyright © 2012 Nathan Hjelm <hjelmn@cs.unm.edu>
 * For more information, please visit: http://libusbx.org
 */

/*
 * Converted/butchered to a D-Language interface
 * Ross Lonstein <lonstein@brightboxcharge.com>
 * Brightbox, Inc. 2015
 */

module libusb;

import core.sys.posix.sys.time : timeval;

const INT_MAX = 2147483647; // taken from limits.h...

const LIBUSBX_API_VERSION =  0x01000102;

/* Descriptor sizes per descriptor type */
const LIBUSB_DT_DEVICE_SIZE                = 18;
const LIBUSB_DT_CONFIG_SIZE                = 9;
const LIBUSB_DT_INTERFACE_SIZE             = 9;
const LIBUSB_DT_ENDPOINT_SIZE              = 7;
const LIBUSB_DT_ENDPOINT_AUDIO_SIZE        = 9;   /* Audio extension */
const LIBUSB_DT_HUB_NONVAR_SIZE            = 7;
const LIBUSB_DT_SS_ENDPOINT_COMPANION_SIZE = 6;
const LIBUSB_DT_BOS_SIZE                   = 5;
const LIBUSB_DT_DEVICE_CAPABILITY_SIZE     = 3;

/* BOS descriptor sizes */
const LIBUSB_BT_USB_2_0_EXTENSION_SIZE        =  7;
const LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE = 10;
const LIBUSB_BT_CONTAINER_ID_SIZE             = 20;

/* We unwrap the BOS => define its max size */
const LIBUSB_DT_BOS_MAX_SIZE =
  ((LIBUSB_DT_BOS_SIZE)+(LIBUSB_BT_USB_2_0_EXTENSION_SIZE)
   + (LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE)+(LIBUSB_BT_CONTAINER_ID_SIZE));

const LIBUSB_ENDPOINT_ADDRESS_MASK = 0x0f;    /* in bEndpointAddress */
const LIBUSB_ENDPOINT_DIR_MASK     = 0x80;

const LIBUSB_TRANSFER_TYPE_MASK = 0x03;    /* in bmAttributes */

const LIBUSB_ISO_SYNC_TYPE_MASK = 0x0C;

const LIBUSB_ISO_USAGE_TYPE_MASK = 0x30;

const LIBUSB_CONTROL_SETUP_SIZE = libusb_control_setup.sizeof;

/* Total number of error codes in enum libusb_error */
const LIBUSB_ERROR_COUNT = 14;

/** \ingroup hotplug
 * Wildcard matching for hotplug events */
const LIBUSB_HOTPLUG_MATCH_ANY = -1;

ushort libusb_cpu_to_le16(const ushort x) {
  union _tmp_union {
    ubyte  b8[2];
    ushort b16;
  }

  _tmp_union _tmp;

  _tmp.b8[1] = cast(ubyte)(x >> 8);
  _tmp.b8[0] = cast(ubyte)(x & 0xff);
  return _tmp.b16;
}

/* sync I/O */
extern(C) int libusb_control_transfer(libusb_device_handle *dev_handle,
                                      ubyte request_type, ubyte bRequest, ushort wValue, ushort wIndex,
                                      char *data, ushort wLength, uint timeout);

extern(C) int libusb_bulk_transfer(libusb_device_handle *dev_handle,
                                   char endpoint, char *data, int length,
                                   int *actual_length, uint timeout);

extern(C) int libusb_interrupt_transfer(libusb_device_handle *dev_handle,
                                        char endpoint, char *data, int length,
                                        int *actual_length, uint timeout);

extern (C) {

/* standard USB stuff */

/** \ingroup desc
 * Device and/or Interface Class codes */
enum libusb_class_code : ubyte {
    /** In the context of a \ref libusb_device_descriptor "device descriptor",
     * this bDeviceClass value indicates that each interface specifies its
     * own class information and all interfaces operate independently.
     */
    LIBUSB_CLASS_PER_INTERFACE = 0,

    /** Audio class */
    LIBUSB_CLASS_AUDIO = 1,

    /** Communications class */
    LIBUSB_CLASS_COMM = 2,

    /** Human Interface Device class */
    LIBUSB_CLASS_HID = 3,

    /** Physical */
    LIBUSB_CLASS_PHYSICAL = 5,

    /** Printer class */
    LIBUSB_CLASS_PRINTER = 7,

    /** Image class */
    LIBUSB_CLASS_PTP = 6, /* legacy name from libusb-0.1 usb.h */
    LIBUSB_CLASS_IMAGE = 6,

    /** Mass storage class */
    LIBUSB_CLASS_MASS_STORAGE = 8,

    /** Hub class */
    LIBUSB_CLASS_HUB = 9,

    /** Data class */
    LIBUSB_CLASS_DATA = 10,

    /** Smart Card */
    LIBUSB_CLASS_SMART_CARD = 0x0b,

    /** Content Security */
    LIBUSB_CLASS_CONTENT_SECURITY = 0x0d,

    /** Video */
    LIBUSB_CLASS_VIDEO = 0x0e,

    /** Personal Healthcare */
    LIBUSB_CLASS_PERSONAL_HEALTHCARE = 0x0f,

    /** Diagnostic Device */
    LIBUSB_CLASS_DIAGNOSTIC_DEVICE = 0xdc,

    /** Wireless class */
    LIBUSB_CLASS_WIRELESS = 0xe0,

    /** Application class */
    LIBUSB_CLASS_APPLICATION = 0xfe,

    /** Class is vendor-specific */
    LIBUSB_CLASS_VENDOR_SPEC = 0xff
};

/** \ingroup desc
 * Descriptor types as defined by the USB specification. */
enum libusb_descriptor_type
{
    /** Device descriptor. See libusb_device_descriptor. */
    LIBUSB_DT_DEVICE = 0x01,

    /** Configuration descriptor. See libusb_config_descriptor. */
    LIBUSB_DT_CONFIG = 0x02,

    /** String descriptor */
    LIBUSB_DT_STRING = 0x03,

    /** Interface descriptor. See libusb_interface_descriptor. */
    LIBUSB_DT_INTERFACE = 0x04,

    /** Endpoint descriptor. See libusb_endpoint_descriptor. */
    LIBUSB_DT_ENDPOINT = 0x05,

    /** BOS descriptor */
    LIBUSB_DT_BOS = 0x0f,

    /** Device Capability descriptor */
    LIBUSB_DT_DEVICE_CAPABILITY = 0x10,

    /** HID descriptor */
    LIBUSB_DT_HID = 0x21,

    /** HID report descriptor */
    LIBUSB_DT_REPORT = 0x22,

    /** Physical descriptor */
    LIBUSB_DT_PHYSICAL = 0x23,

    /** Hub descriptor */
    LIBUSB_DT_HUB = 0x29,

    /** SuperSpeed Hub descriptor */
    LIBUSB_DT_SUPERSPEED_HUB = 0x2a,

    /** SuperSpeed Endpoint Companion descriptor */
    LIBUSB_DT_SS_ENDPOINT_COMPANION = 0x30
};

/** \ingroup desc
 * Endpoint direction. Values for bit 7 of the
 * \ref libusb_endpoint_descriptor::bEndpointAddress "endpoint address" scheme.
 */
enum libusb_endpoint_direction {
    LIBUSB_ENDPOINT_IN  = 0x80,    /** In:  device-to-host */
    LIBUSB_ENDPOINT_OUT = 0x00     /** Out: host-to-device */
};

/** \ingroup desc
 * Endpoint transfer type. Values for bits 0:1 of the
 * \ref libusb_endpoint_descriptor::bmAttributes "endpoint attributes" field.
 */
enum libusb_transfer_type {
  LIBUSB_TRANSFER_TYPE_CONTROL     = 0,   /** Control endpoint */
  LIBUSB_TRANSFER_TYPE_ISOCHRONOUS = 1,   /** Isochronous endpoint */
  LIBUSB_TRANSFER_TYPE_BULK        = 2,   /** Bulk endpoint */
  LIBUSB_TRANSFER_TYPE_INTERRUPT   = 3    /** Interrupt endpoint */
};

/** \ingroup misc
 * Standard requests, as defined in table 9-5 of the USB 3.0 specifications */
enum libusb_standard_request
{
    /** Request status of the specific recipient */
    LIBUSB_REQUEST_GET_STATUS = 0x00,

    /** Clear or disable a specific feature */
    LIBUSB_REQUEST_CLEAR_FEATURE = 0x01,

    /* 0x02 is reserved */

    /** Set or enable a specific feature */
    LIBUSB_REQUEST_SET_FEATURE = 0x03,

    /* 0x04 is reserved */

    /** Set device address for all future accesses */
    LIBUSB_REQUEST_SET_ADDRESS = 0x05,

    /** Get the specified descriptor */
    LIBUSB_REQUEST_GET_DESCRIPTOR = 0x06,

    /** Used to update existing descriptors or add new descriptors */
    LIBUSB_REQUEST_SET_DESCRIPTOR = 0x07,

    /** Get the current device configuration value */
    LIBUSB_REQUEST_GET_CONFIGURATION = 0x08,

    /** Set device configuration */
    LIBUSB_REQUEST_SET_CONFIGURATION = 0x09,

    /** Return the selected alternate setting for the specified interface */
    LIBUSB_REQUEST_GET_INTERFACE = 0x0A,

    /** Select an alternate interface for the specified interface */
    LIBUSB_REQUEST_SET_INTERFACE = 0x0B,

    /** Set then report an endpoint's synchronization frame */
    LIBUSB_REQUEST_SYNCH_FRAME = 0x0C,

    /** Sets both the U1 and U2 Exit Latency */
    LIBUSB_REQUEST_SET_SEL = 0x30,

    /** Delay from the time a host transmits a packet to the time it is
      * received by the device. */
    LIBUSB_SET_ISOCH_DELAY = 0x31,
};

/** \ingroup misc
 * Request type bits of the
 * \ref libusb_control_setup::bmRequestType "bmRequestType" field in control
 * transfers. */
enum libusb_request_type
{
    /** Standard */
    LIBUSB_REQUEST_TYPE_STANDARD = (0x00 << 5),

    /** Class */
    LIBUSB_REQUEST_TYPE_CLASS = (0x01 << 5),

    /** Vendor */
    LIBUSB_REQUEST_TYPE_VENDOR = (0x02 << 5),

    /** Reserved */
    LIBUSB_REQUEST_TYPE_RESERVED = (0x03 << 5)
};

/** \ingroup misc
 * Recipient bits of the
 * \ref libusb_control_setup::bmRequestType "bmRequestType" field in control
 * transfers. Values 4 through 31 are reserved. */
enum libusb_request_recipient
{
    /** Device */
    LIBUSB_RECIPIENT_DEVICE = 0x00,

    /** Interface */
    LIBUSB_RECIPIENT_INTERFACE = 0x01,

    /** Endpoint */
    LIBUSB_RECIPIENT_ENDPOINT = 0x02,

    /** Other */
    LIBUSB_RECIPIENT_OTHER = 0x03,
};

/** \ingroup desc
 * Synchronization type for isochronous endpoints. Values for bits 2:3 of the
 * \ref libusb_endpoint_descriptor::bmAttributes "bmAttributes" field in
 * libusb_endpoint_descriptor.
 */
enum libusb_iso_sync_type
{
    /** No synchronization */
    LIBUSB_ISO_SYNC_TYPE_NONE = 0,

    /** Asynchronous */
    LIBUSB_ISO_SYNC_TYPE_ASYNC = 1,

    /** Adaptive */
    LIBUSB_ISO_SYNC_TYPE_ADAPTIVE = 2,

    /** Synchronous */
    LIBUSB_ISO_SYNC_TYPE_SYNC = 3
};

/** \ingroup desc
 * Usage type for isochronous endpoints. Values for bits 4:5 of the
 * \ref libusb_endpoint_descriptor::bmAttributes "bmAttributes" field in
 * libusb_endpoint_descriptor.
 */
enum libusb_iso_usage_type
{
    /** Data endpoint */
    LIBUSB_ISO_USAGE_TYPE_DATA = 0,

    /** Feedback endpoint */
    LIBUSB_ISO_USAGE_TYPE_FEEDBACK = 1,

    /** Implicit feedback Data endpoint */
    LIBUSB_ISO_USAGE_TYPE_IMPLICIT = 2,
};

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
 * A collection of alternate settings for a particular USB interface.
 */
struct libusb_interface {
  /** Array of interface descriptors. The length of this array is determined
   * by the num_altsetting field. */
  libusb_interface_descriptor *altsetting;

  /** The number of alternate settings that belong to this interface */
  int num_altsetting;
};
 

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup desc
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

/** \ingroup asyncio
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

/** \ingroup lib
 * Structure providing the version of the libusbx runtime
 */
struct libusb_version
{
    /** Library major version. */
    const ushort major;

    /** Library minor version. */
    const ushort minor;

    /** Library micro version. */
    const ushort micro;

    /** Library nano version. */
    const ushort nano;

    /** Library release candidate suffix string, e.g. "-rc4". */
    const char *rc;

    /** For ABI compatibility only. */
    const char *describe;
};

/** \ingroup dev
 * Speed codes. Indicates the speed at which the device is operating.
 */
enum libusb_speed
{
    /** The OS doesn't report or know the device speed. */
    LIBUSB_SPEED_UNKNOWN = 0,

    /** The device is operating at low speed (1.5MBit/s). */
    LIBUSB_SPEED_LOW = 1,

    /** The device is operating at full speed (12MBit/s). */
    LIBUSB_SPEED_FULL = 2,

    /** The device is operating at high speed (480MBit/s). */
    LIBUSB_SPEED_HIGH = 3,

    /** The device is operating at super speed (5000MBit/s). */
    LIBUSB_SPEED_SUPER = 4,
};

/** \ingroup dev
 * Supported speeds (wSpeedSupported) bitfield. Indicates what
 * speeds the device supports.
 */
enum libusb_supported_speed
{
    /** Low speed operation supported (1.5MBit/s). */
    LIBUSB_LOW_SPEED_OPERATION   = 1,

    /** Full speed operation supported (12MBit/s). */
    LIBUSB_FULL_SPEED_OPERATION  = 2,

    /** High speed operation supported (480MBit/s). */
    LIBUSB_HIGH_SPEED_OPERATION  = 4,

    /** Superspeed operation supported (5000MBit/s). */
    LIBUSB_SUPER_SPEED_OPERATION = 8,
};

/** \ingroup dev
 * Masks for the bits of the
 * \ref libusb_usb_2_0_extension_descriptor::bmAttributes "bmAttributes" field
 * of the USB 2.0 Extension descriptor.
 */
enum libusb_usb_2_0_extension_attributes
{
    /** Supports Link Power Management (LPM) */
    LIBUSB_BM_LPM_SUPPORT = 2,
};

/** \ingroup dev
 * Masks for the bits of the
 * \ref libusb_ss_usb_device_capability_descriptor::bmAttributes "bmAttributes" field
 * field of the SuperSpeed USB Device Capability descriptor.
 */
enum libusb_ss_usb_device_capability_attributes
{
    /** Supports Latency Tolerance Messages (LTM) */
    LIBUSB_BM_LTM_SUPPORT = 2,
};

/** \ingroup dev
 * USB capability types
 */
enum libusb_bos_type
{
    /** Wireless USB device capability */
    LIBUSB_BT_WIRELESS_USB_DEVICE_CAPABILITY    = 1,

    /** USB 2.0 extensions */
    LIBUSB_BT_USB_2_0_EXTENSION         = 2,

    /** SuperSpeed USB device capability */
    LIBUSB_BT_SS_USB_DEVICE_CAPABILITY      = 3,

    /** Container ID type */
    LIBUSB_BT_CONTAINER_ID              = 4,
};

/** \ingroup misc
 * Error codes. Most libusbx functions return 0 on success or one of these
 * codes on failure.
 * You can call libusb_error_name() to retrieve a string representation of an
 * error code or libusb_strerror() to get an end-user suitable description of
 * an error code.
 */
enum libusb_error
{
    /** Success (no error) */
    LIBUSB_SUCCESS = 0,

    /** Input/output error */
    LIBUSB_ERROR_IO = -1,

    /** Invalid parameter */
    LIBUSB_ERROR_INVALID_PARAM = -2,

    /** Access denied (insufficient permissions) */
    LIBUSB_ERROR_ACCESS = -3,

    /** No such device (it may have been disconnected) */
    LIBUSB_ERROR_NO_DEVICE = -4,

    /** Entity not found */
    LIBUSB_ERROR_NOT_FOUND = -5,

    /** Resource busy */
    LIBUSB_ERROR_BUSY = -6,

    /** Operation timed out */
    LIBUSB_ERROR_TIMEOUT = -7,

    /** Overflow */
    LIBUSB_ERROR_OVERFLOW = -8,

    /** Pipe error */
    LIBUSB_ERROR_PIPE = -9,

    /** System call interrupted (perhaps due to signal) */
    LIBUSB_ERROR_INTERRUPTED = -10,

    /** Insufficient memory */
    LIBUSB_ERROR_NO_MEM = -11,

    /** Operation not supported or unimplemented on this platform */
    LIBUSB_ERROR_NOT_SUPPORTED = -12,

    /* NB: Remember to update LIBUSB_ERROR_COUNT below as well as the
       message strings in strerror.c when adding new error codes here. */

    /** Other error */
    LIBUSB_ERROR_OTHER = -99,
};

/** \ingroup asyncio
 * Transfer status codes */
enum libusb_transfer_status
{
    /** Transfer completed without error. Note that this does not indicate
     * that the entire amount of requested data was transferred. */
    LIBUSB_TRANSFER_COMPLETED,

    /** Transfer failed */
    LIBUSB_TRANSFER_ERROR,

    /** Transfer timed out */
    LIBUSB_TRANSFER_TIMED_OUT,

    /** Transfer was cancelled */
    LIBUSB_TRANSFER_CANCELLED,

    /** For bulk/interrupt endpoints: halt condition detected (endpoint
     * stalled). For control endpoints: control request not supported. */
    LIBUSB_TRANSFER_STALL,

    /** Device was disconnected */
    LIBUSB_TRANSFER_NO_DEVICE,

    /** Device sent more data than requested */
    LIBUSB_TRANSFER_OVERFLOW,

    /* NB! Remember to update libusb_error_name()
       when adding new status codes here. */
};

/** \ingroup asyncio
 * libusb_transfer.flags values */
enum libusb_transfer_flags
{
    /** Report short frames as errors */
    LIBUSB_TRANSFER_SHORT_NOT_OK = 1<<0,

    /** Automatically free() transfer buffer during libusb_free_transfer() */
    LIBUSB_TRANSFER_FREE_BUFFER = 1<<1,

    /** Automatically call libusb_free_transfer() after callback returns.
     * If this flag is set, it is illegal to call libusb_free_transfer()
     * from your transfer callback, as this will result in a double-free
     * when this flag is acted upon. */
    LIBUSB_TRANSFER_FREE_TRANSFER = 1<<2,

    /** Terminate transfers that are a multiple of the endpoint's
     * wMaxPacketSize with an extra zero length packet. This is useful
     * when a device protocol mandates that each logical request is
     * terminated by an incomplete packet (i.e. the logical requests are
     * not separated by other means).
     *
     * This flag only affects host-to-device transfers to bulk and interrupt
     * endpoints. In other situations, it is ignored.
     *
     * This flag only affects transfers with a length that is a multiple of
     * the endpoint's wMaxPacketSize. On transfers of other lengths, this
     * flag has no effect. Therefore, if you are working with a device that
     * needs a ZLP whenever the end of the logical request falls on a packet
     * boundary, then it is sensible to set this flag on <em>every</em>
     * transfer (you do not have to worry about only setting it on transfers
     * that end on the boundary).
     *
     * This flag is currently only supported on Linux.
     * On other systems, libusb_submit_transfer() will return
     * LIBUSB_ERROR_NOT_SUPPORTED for every transfer where this flag is set.
     *
     * Available since libusb-1.0.9.
     */
    LIBUSB_TRANSFER_ADD_ZERO_PACKET = 1 << 3,
};

/** \ingroup asyncio
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

/** \ingroup asyncio
 * Asynchronous transfer callback function type. When submitting asynchronous
 * transfers, you pass a pointer to a callback function of this type via the
 * \ref libusb_transfer::callback "callback" member of the libusb_transfer
 * structure. libusbx will call this function later, when the transfer has
 * completed or failed. See \ref asyncio for more information.
 * \param transfer The libusb_transfer struct the callback function is being
 * notified about.
 */
//typedef void (LIBUSB_CALL *libusb_transfer_cb_fn)(libusb_transfer *transfer);
alias libusb_transfer_cb_fn = void function(libusb_transfer *transfer);

/** \ingroup asyncio
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

/** \ingroup misc
 * Capabilities supported by an instance of libusb on the current running
 * platform. Test if the loaded library supports a given capability by calling
 * \ref libusb_has_capability().
 */
enum libusb_capability
{
    /** The libusb_has_capability() API is available. */
    LIBUSB_CAP_HAS_CAPABILITY = 0x0000,
    /** Hotplug support is available on this platform. */
    LIBUSB_CAP_HAS_HOTPLUG = 0x0001,
    /** The library can access HID devices without requiring user intervention.
     * Note that before being able to actually access an HID device, you may
     * still have to call additional libusbx functions such as
     * \ref libusb_detach_kernel_driver(). */
    LIBUSB_CAP_HAS_HID_ACCESS = 0x0100,
    /** The library supports detaching of the default USB driver, using
     * \ref libusb_detach_kernel_driver(), if one is set by the OS kernel */
    LIBUSB_CAP_SUPPORTS_DETACH_KERNEL_DRIVER = 0x0101
};

/** \ingroup lib
 *  Log message levels.
 *  - LIBUSB_LOG_LEVEL_NONE (0)    : no messages ever printed by the library (default)
 *  - LIBUSB_LOG_LEVEL_ERROR (1)   : error messages are printed to stderr
 *  - LIBUSB_LOG_LEVEL_WARNING (2) : warning and error messages are printed to stderr
 *  - LIBUSB_LOG_LEVEL_INFO (3)    : informational messages are printed to stdout, warning
 *    and error messages are printed to stderr
 *  - LIBUSB_LOG_LEVEL_DEBUG (4)   : debug and informational messages are printed to stdout,
 *    warnings and errors to stderr
 */
enum libusb_log_level
{
    LIBUSB_LOG_LEVEL_NONE = 0,
    LIBUSB_LOG_LEVEL_ERROR,
    LIBUSB_LOG_LEVEL_WARNING,
    LIBUSB_LOG_LEVEL_INFO,
    LIBUSB_LOG_LEVEL_DEBUG,
};

int libusb_init(libusb_context **ctx);
void libusb_exit(libusb_context *ctx);
void libusb_set_debug(libusb_context *ctx, int level);
libusb_version libusb_get_version();
int libusb_has_capability(uint capability);
char* libusb_error_name(int errcode);
int libusb_setlocale(const char *locale);
char* libusb_strerror(int errcode);

ptrdiff_t libusb_get_device_list(libusb_context *ctx,
        libusb_device ***list);
void libusb_free_device_list(libusb_device **list,
        int unref_devices);
libusb_device* libusb_ref_device(libusb_device *dev);
void libusb_unref_device(libusb_device *dev);

int libusb_get_configuration(libusb_device_handle *dev,
        int *config);
int libusb_get_device_descriptor(libusb_device *dev,
        libusb_device_descriptor *desc);
int libusb_get_active_config_descriptor(libusb_device *dev,
        libusb_config_descriptor **config);
int libusb_get_config_descriptor(libusb_device *dev,
        ubyte config_index, libusb_config_descriptor **config);
int libusb_get_config_descriptor_by_value(libusb_device *dev,
        ubyte bConfigurationValue, libusb_config_descriptor **config);
void libusb_free_config_descriptor(
    libusb_config_descriptor *config);
int libusb_get_ss_endpoint_companion_descriptor(
    libusb_context *ctx,
    const libusb_endpoint_descriptor *endpoint,
    libusb_ss_endpoint_companion_descriptor **ep_comp);
void libusb_free_ss_endpoint_companion_descriptor(
    libusb_ss_endpoint_companion_descriptor *ep_comp);
int libusb_get_bos_descriptor(libusb_device_handle *handle,
        libusb_bos_descriptor **bos);
void libusb_free_bos_descriptor(libusb_bos_descriptor *bos);
int libusb_get_usb_2_0_extension_descriptor(
    libusb_context *ctx,
    libusb_bos_dev_capability_descriptor *dev_cap,
    libusb_usb_2_0_extension_descriptor **usb_2_0_extension);
void libusb_free_usb_2_0_extension_descriptor(
    libusb_usb_2_0_extension_descriptor *usb_2_0_extension);
int libusb_get_ss_usb_device_capability_descriptor(
    libusb_context *ctx,
    libusb_bos_dev_capability_descriptor *dev_cap,
    libusb_ss_usb_device_capability_descriptor **ss_usb_device_cap);
void libusb_free_ss_usb_device_capability_descriptor(
    libusb_ss_usb_device_capability_descriptor *ss_usb_device_cap);
int libusb_get_container_id_descriptor(libusb_context *ctx,
        libusb_bos_dev_capability_descriptor *dev_cap,
        libusb_container_id_descriptor **container_id);
void libusb_free_container_id_descriptor(
    libusb_container_id_descriptor *container_id);
ubyte libusb_get_bus_number(libusb_device *dev);
ubyte libusb_get_port_number(libusb_device *dev);
int libusb_get_port_numbers(libusb_device *dev, ubyte *port_numbers, int port_numbers_len);

  //LIBUSB_DEPRECATED_FOR(libusb_get_port_numbers)

int libusb_get_port_path(libusb_context *ctx, libusb_device *dev, ubyte *path, ubyte path_length);
libusb_device* libusb_get_parent(libusb_device *dev);
ubyte libusb_get_device_address(libusb_device *dev);
int libusb_get_device_speed(libusb_device *dev);
int libusb_get_max_packet_size(libusb_device *dev,  char endpoint);
int libusb_get_max_iso_packet_size(libusb_device *dev,  char endpoint);

int libusb_open(libusb_device *dev, libusb_device_handle **handle);
void libusb_close(libusb_device_handle *dev_handle);
libusb_device* libusb_get_device(libusb_device_handle *dev_handle);

int libusb_set_configuration(libusb_device_handle *dev,
        int configuration);
int libusb_claim_interface(libusb_device_handle *dev,
                                       int interface_number);
int libusb_release_interface(libusb_device_handle *dev,
        int interface_number);

libusb_device_handle* libusb_open_device_with_vid_pid(libusb_context *ctx, ushort vendor_id, ushort product_id);

int libusb_set_interface_alt_setting(libusb_device_handle *dev,
        int interface_number, int alternate_setting);
int libusb_clear_halt(libusb_device_handle *dev,
                                  char endpoint);
int libusb_reset_device(libusb_device_handle *dev);

int libusb_kernel_driver_active(libusb_device_handle *dev,
        int interface_number);
int libusb_detach_kernel_driver(libusb_device_handle *dev,
        int interface_number);
int libusb_attach_kernel_driver(libusb_device_handle *dev,
        int interface_number);
int libusb_set_auto_detach_kernel_driver(
    libusb_device_handle *dev, int enable);

/* async I/O */

/** \ingroup asyncio
 * Get the data section of a control transfer. This convenience function is here
 * to remind you that the data does not start until 8 bytes into the actual
 * buffer, as the setup packet comes first.
 *
 * Calling this function only makes sense from a transfer callback function,
 * or situations where you have already allocated a suitably sized buffer at
 * transfer->buffer.
 *
 * \param transfer a transfer
 * \returns pointer to the first byte of the data section
 */
static char *libusb_control_transfer_get_data(libusb_transfer *transfer) {
  return transfer.buffer + LIBUSB_CONTROL_SETUP_SIZE;
}

/** \ingroup asyncio
 * Get the control setup packet of a control transfer. This convenience
 * function is here to remind you that the control setup occupies the first
 * 8 bytes of the transfer data buffer.
 *
 * Calling this function only makes sense from a transfer callback function,
 * or situations where you have already allocated a suitably sized buffer at
 * transfer->buffer.
 *
 * \param transfer a transfer
 * \returns a casted pointer to the start of the transfer data buffer
 */
static libusb_control_setup *libusb_control_transfer_get_setup(libusb_transfer *transfer) {
  return cast(libusb_control_setup*)(cast(void *) transfer.buffer);
}

/** \ingroup asyncio
 * Helper function to populate the setup packet (first 8 bytes of the data
 * buffer) for a control transfer. The wIndex, wValue and wLength values should
 * be given in host-endian byte order.
 *
 * \param buffer buffer to output the setup packet into
 * This pointer must be aligned to at least 2 bytes boundary.
 * \param bmRequestType see the
 * \ref libusb_control_setup::bmRequestType "bmRequestType" field of
 * \ref libusb_control_setup
 * \param bRequest see the
 * \ref libusb_control_setup::bRequest "bRequest" field of
 * \ref libusb_control_setup
 * \param wValue see the
 * \ref libusb_control_setup::wValue "wValue" field of
 * \ref libusb_control_setup
 * \param wIndex see the
 * \ref libusb_control_setup::wIndex "wIndex" field of
 * \ref libusb_control_setup
 * \param wLength see the
 * \ref libusb_control_setup::wLength "wLength" field of
 * \ref libusb_control_setup
 */
static void libusb_fill_control_setup(char *buffer, ubyte bmRequestType,
                                      ubyte bRequest, ushort wValue, ushort wIndex,
                                      ushort wLength) {
  libusb_control_setup *setup = cast(libusb_control_setup *)(cast(void *) buffer);
  setup.bmRequestType = bmRequestType;
  setup.bRequest = bRequest;
  setup.wValue = libusb_cpu_to_le16(wValue);
  setup.wIndex = libusb_cpu_to_le16(wIndex);
  setup.wLength = libusb_cpu_to_le16(wLength);
}

libusb_transfer* libusb_alloc_transfer(int iso_packets);
int libusb_submit_transfer(libusb_transfer *transfer);
int libusb_cancel_transfer(libusb_transfer *transfer);
void libusb_free_transfer(libusb_transfer *transfer);

/** \ingroup asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for a control transfer.
 *
 * If you pass a transfer buffer to this function, the first 8 bytes will
 * be interpreted as a control setup packet, and the wLength field will be
 * used to automatically populate the \ref libusb_transfer::length "length"
 * field of the transfer. Therefore the recommended approach is:
 * -# Allocate a suitably sized data buffer (including space for control setup)
 * -# Call libusb_fill_control_setup()
 * -# If this is a host-to-device transfer with a data stage, put the data
 *    in place after the setup packet
 * -# Call this function
 * -# Call libusb_submit_transfer()
 *
 * It is also legal to pass a NULL buffer to this function, in which case this
 * function will not attempt to populate the length field. Remember that you
 * must then populate the buffer and length fields later.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param buffer data buffer. If provided, this function will interpret the
 * first 8 bytes as a setup packet and infer the transfer length from that.
 * This pointer must be aligned to at least 2 bytes boundary.
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds
 */
static void libusb_fill_control_transfer(
    libusb_transfer *transfer, libusb_device_handle *dev_handle,
    char *buffer, libusb_transfer_cb_fn callback, void *user_data,
    uint timeout) {
  libusb_control_setup *setup = cast(libusb_control_setup *)(cast(void *) buffer);
  transfer.dev_handle = dev_handle;
  transfer.endpoint = 0;
  transfer.type = libusb_transfer_type.LIBUSB_TRANSFER_TYPE_CONTROL;
  transfer.timeout = timeout;
  transfer.buffer = buffer;

  if (setup) {
    transfer.length = cast(int)(LIBUSB_CONTROL_SETUP_SIZE+libusb_cpu_to_le16(setup.wLength));
  }

  transfer.user_data = user_data;
  transfer.callback = callback;
}

/** \ingroup asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for a bulk transfer.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param buffer data buffer
 * \param length length of data buffer
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds
 */
static void libusb_fill_bulk_transfer(libusb_transfer *transfer,
        libusb_device_handle *dev_handle, char endpoint,
        char *buffer, int length, libusb_transfer_cb_fn callback,
        void *user_data, uint timeout)
{
    transfer.dev_handle = dev_handle;
    transfer.endpoint = endpoint;
    transfer.type = libusb_transfer_type.LIBUSB_TRANSFER_TYPE_BULK;
    transfer.timeout = timeout;
    transfer.buffer = buffer;
    transfer.length = length;
    transfer.user_data = user_data;
    transfer.callback = callback;
}

/** \ingroup asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for an interrupt transfer.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param buffer data buffer
 * \param length length of data buffer
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds
 */
static void libusb_fill_interrupt_transfer(
    libusb_transfer *transfer, libusb_device_handle *dev_handle,
    char endpoint, char *buffer, int length,
    libusb_transfer_cb_fn callback, void *user_data, uint timeout)
{
    transfer.dev_handle = dev_handle;
    transfer.endpoint = endpoint;
    transfer.type = libusb_transfer_type.LIBUSB_TRANSFER_TYPE_INTERRUPT;
    transfer.timeout = timeout;
    transfer.buffer = buffer;
    transfer.length = length;
    transfer.user_data = user_data;
    transfer.callback = callback;
}

/** \ingroup asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for an isochronous transfer.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param buffer data buffer
 * \param length length of data buffer
 * \param num_iso_packets the number of isochronous packets
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds
 */
static void libusb_fill_iso_transfer(libusb_transfer *transfer,
        libusb_device_handle *dev_handle, char endpoint,
        char *buffer, int length, int num_iso_packets,
        libusb_transfer_cb_fn callback, void *user_data, uint timeout)
{
    transfer.dev_handle = dev_handle;
    transfer.endpoint = endpoint;
    transfer.type = libusb_transfer_type.LIBUSB_TRANSFER_TYPE_ISOCHRONOUS;
    transfer.timeout = timeout;
    transfer.buffer = buffer;
    transfer.length = length;
    transfer.num_iso_packets = num_iso_packets;
    transfer.user_data = user_data;
    transfer.callback = callback;
}

/** \ingroup asyncio
 * Convenience function to set the length of all packets in an isochronous
 * transfer, based on the num_iso_packets field in the transfer structure.
 *
 * \param transfer a transfer
 * \param length the length to set in each isochronous packet descriptor
 * \see libusb_get_max_packet_size()
 */
static void libusb_set_iso_packet_lengths(libusb_transfer *transfer, uint length) {
    int i;

    for (i = 0; i < transfer.num_iso_packets; i++)
    { transfer.iso_packet_desc[i].length = length; }
}

/** \ingroup asyncio
 * Convenience function to locate the position of an isochronous packet
 * within the buffer of an isochronous transfer.
 *
 * This is a thorough function which loops through all preceding packets,
 * accumulating their lengths to find the position of the specified packet.
 * Typically you will assign equal lengths to each packet in the transfer,
 * and hence the above method is sub-optimal. You may wish to use
 * libusb_get_iso_packet_buffer_simple() instead.
 *
 * \param transfer a transfer
 * \param packet the packet to return the address of
 * \returns the base address of the packet buffer inside the transfer buffer,
 * or NULL if the packet does not exist.
 * \see libusb_get_iso_packet_buffer_simple()
 */
static char *libusb_get_iso_packet_buffer(
    libusb_transfer *transfer, uint packet)
{
    int i;
    size_t offset = 0;
    int _packet;

    /* oops..slight bug in the API. packet is an unsigned int, but we use
     * signed integers almost everywhere else. range-check and convert to
     * signed to avoid compiler warnings. FIXME for libusb-2. */
    if (packet > INT_MAX)
    { return null; }

    _packet = cast(int)packet;

    if (_packet >= transfer.num_iso_packets)
    { return null; }

    for (i = 0; i < _packet; i++)
    { offset += transfer.iso_packet_desc[i].length; }

    return transfer.buffer + offset;
}

/** \ingroup asyncio
 * Convenience function to locate the position of an isochronous packet
 * within the buffer of an isochronous transfer, for transfers where each
 * packet is of identical size.
 *
 * This function relies on the assumption that every packet within the transfer
 * is of identical size to the first packet. Calculating the location of
 * the packet buffer is then just a simple calculation:
 * <tt>buffer + (packet_size * packet)</tt>
 *
 * Do not use this function on transfers other than those that have identical
 * packet lengths for each packet.
 *
 * \param transfer a transfer
 * \param packet the packet to return the address of
 * \returns the base address of the packet buffer inside the transfer buffer,
 * or NULL if the packet does not exist.
 * \see libusb_get_iso_packet_buffer()
 */
static char *libusb_get_iso_packet_buffer_simple(libusb_transfer *transfer, uint packet) {
    int _packet;

    /* oops..slight bug in the API. packet is an unsigned int, but we use
     * signed integers almost everywhere else. range-check and convert to
     * signed to avoid compiler warnings. FIXME for libusb-2. */
    if (packet > INT_MAX)
    { return null; }

    _packet = cast(int)packet;

    if (_packet >= transfer.num_iso_packets)
    { return null; }

    return transfer.buffer + (cast(int)(transfer.iso_packet_desc[0].length * _packet));
}

/** \ingroup desc
 * Retrieve a descriptor from the default control pipe.
 * This is a convenience function which formulates the appropriate control
 * message to retrieve the descriptor.
 *
 * \param dev a device handle
 * \param desc_type the descriptor type, see \ref libusb_descriptor_type
 * \param desc_index the index of the descriptor to retrieve
 * \param data output buffer for descriptor
 * \param length size of data buffer
 * \returns number of bytes returned in data, or LIBUSB_ERROR code on failure
 */
static int libusb_get_descriptor(libusb_device_handle *dev,
                                        ubyte desc_type, ubyte desc_index, char *data, int length)
{
    return libusb_control_transfer(dev, libusb_endpoint_direction.LIBUSB_ENDPOINT_IN,
                                   libusb_standard_request.LIBUSB_REQUEST_GET_DESCRIPTOR,
                                   cast(ushort)((desc_type << 8) | desc_index),
                                   0,
                                   data,
                                   cast(ushort)length, 1000);
}

/** \ingroup desc
 * Retrieve a descriptor from a device.
 * This is a convenience function which formulates the appropriate control
 * message to retrieve the descriptor. The string returned is Unicode, as
 * detailed in the USB specifications.
 *
 * \param dev a device handle
 * \param desc_index the index of the descriptor to retrieve
 * \param langid the language ID for the string descriptor
 * \param data output buffer for descriptor
 * \param length size of data buffer
 * \returns number of bytes returned in data, or LIBUSB_ERROR code on failure
 * \see libusb_get_string_descriptor_ascii()
 */
static int libusb_get_string_descriptor(libusb_device_handle *dev,
        ubyte desc_index, ushort langid, char *data, int length)
{
    return libusb_control_transfer(dev, libusb_endpoint_direction.LIBUSB_ENDPOINT_IN,
                                   libusb_standard_request.LIBUSB_REQUEST_GET_DESCRIPTOR,
                                   cast(ushort)((libusb_descriptor_type.LIBUSB_DT_STRING << 8) | desc_index),
                                   langid,
                                   data,
                                   cast(ushort)length,
                                   1000);
}

int libusb_get_string_descriptor_ascii(libusb_device_handle *dev,
        ubyte desc_index, char *data, int length);

/* polling and timeouts */

int libusb_try_lock_events(libusb_context *ctx);
void libusb_lock_events(libusb_context *ctx);
void libusb_unlock_events(libusb_context *ctx);
int libusb_event_handling_ok(libusb_context *ctx);
int libusb_event_handler_active(libusb_context *ctx);
void libusb_lock_event_waiters(libusb_context *ctx);
void libusb_unlock_event_waiters(libusb_context *ctx);
int libusb_wait_for_event(libusb_context *ctx, timeval *tv);

int libusb_handle_events_timeout(libusb_context *ctx, timeval *tv);
int libusb_handle_events_timeout_completed(libusb_context *ctx, timeval *tv, int *completed);
int libusb_handle_events(libusb_context *ctx);
int libusb_handle_events_completed(libusb_context *ctx, int *completed);
int libusb_handle_events_locked(libusb_context *ctx, timeval *tv);
int libusb_pollfds_handle_timeouts(libusb_context *ctx);
int libusb_get_next_timeout(libusb_context *ctx, timeval *tv);

/** \ingroup poll
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

/** \ingroup poll
 * Callback function, invoked when a new file descriptor should be added
 * to the set of file descriptors monitored for events.
 * \param fd the new file descriptor
 * \param events events to monitor for, see \ref libusb_pollfd for a
 * description
 * \param user_data User data pointer specified in
 * libusb_set_pollfd_notifiers() call
 * \see libusb_set_pollfd_notifiers()
 */
//typedef void (LIBUSB_CALL *libusb_pollfd_added_cb)(int fd, short events, void *user_data);
alias libusb_pollfd_added_cb = void function(int fd, short events, void *user_data);

/** \ingroup poll
 * Callback function, invoked when a file descriptor should be removed from
 * the set of file descriptors being monitored for events. After returning
 * from this callback, do not use that file descriptor again.
 * \param fd the file descriptor to stop monitoring
 * \param user_data User data pointer specified in
 * libusb_set_pollfd_notifiers() call
 * \see libusb_set_pollfd_notifiers()
 */
//typedef void (LIBUSB_CALL *libusb_pollfd_removed_cb)(int fd, void *user_data);
alias libusb_pollfd_removed_cb = void function(int fd, void *user_data);

libusb_pollfd** libusb_get_pollfds(libusb_context *ctx);

void libusb_set_pollfd_notifiers(libusb_context *ctx,
                                 libusb_pollfd_added_cb added_cb, libusb_pollfd_removed_cb removed_cb,
                                 void *user_data);

/** \ingroup hotplug
 * Callback handle.
 *
 * Callbacks handles are generated by libusb_hotplug_register_callback()
 * and can be used to deregister callbacks. Callback handles are unique
 * per libusb_context and it is safe to call libusb_hotplug_deregister_callback()
 * on an already deregisted callback.
 *
 * Since version 1.0.16, \ref LIBUSBX_API_VERSION >= 0x01000102
 *
 * For more information, see \ref hotplug.
 */
alias libusb_hotplug_callback_handle = int;

/** \ingroup hotplug
 *
 * Since version 1.0.16, \ref LIBUSBX_API_VERSION >= 0x01000102
 *
 * Flags for hotplug events */
enum LIBUSB_HOTPLUG_ENUM {
    /** Arm the callback and fire it for all matching currently attached devices. */
    LIBUSB_HOTPLUG_ENUMERATE = 1,
};
alias libusb_hotplug_flag = LIBUSB_HOTPLUG_ENUM;

/** \ingroup hotplug
 *
 * Since version 1.0.16, \ref LIBUSBX_API_VERSION >= 0x01000102
 *
 * Hotplug events */
enum LIBUSB_HOTPLUG_EVENTS {
  /** A device has been plugged in and is ready to use */
  LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED = 0x01,

  /** A device has left and is no longer available.
   * It is the user's responsibility to call libusb_close on any handle associated with a disconnected device.
   * It is safe to call libusb_get_device_descriptor on a device that has left */
  LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT    = 0x02,
};
alias libusb_hotplug_event = LIBUSB_HOTPLUG_EVENTS;

/** \ingroup hotplug
 * Hotplug callback function type. When requesting hotplug event notifications,
 * you pass a pointer to a callback function of this type.
 *
 * This callback may be called by an internal event thread and as such it is
 * recommended the callback do minimal processing before returning.
 *
 * libusbx will call this function later, when a matching event had happened on
 * a matching device. See \ref hotplug for more information.
 *
 * It is safe to call either libusb_hotplug_register_callback() or
 * libusb_hotplug_deregister_callback() from within a callback function.
 *
 * Since version 1.0.16, \ref LIBUSBX_API_VERSION >= 0x01000102
 *
 * \param ctx            context of this notification
 * \param device         libusb_device this event occurred on
 * \param event          event that occurred
 * \param user_data      user data provided when this callback was registered
 * \returns bool whether this callback is finished processing events.
 *                       returning 1 will cause this callback to be deregistered
 */
// typedef int (*libusb_hotplug_callback_fn)(libusb_context *ctx,
//         libusb_device *device,
//         libusb_hotplug_event event,
//         void *user_data);
alias libusb_hotplug_callback_fn =
  int function(libusb_context *ctx, libusb_device *device,
               libusb_hotplug_event event, void *user_data);

/** \ingroup hotplug
 * Register a hotplug callback function
 *
 * Register a callback with the libusb_context. The callback will fire
 * when a matching event occurs on a matching device. The callback is
 * armed until either it is deregistered with libusb_hotplug_deregister_callback()
 * or the supplied callback returns 1 to indicate it is finished processing events.
 *
 * If the \ref LIBUSB_HOTPLUG_ENUMERATE is passed the callback will be
 * called with a \ref LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED for all devices
 * already plugged into the machine. Note that libusbx modifies its internal
 * device list from a separate thread, while calling hotplug callbacks from
 * libusb_handle_events(), so it is possible for a device to already be present
 * on, or removed from, its internal device list, while the hotplug callbacks
 * still need to be dispatched. This means that when using \ref
 * LIBUSB_HOTPLUG_ENUMERATE, your callback may be called twice for the arrival
 * of the same device, once from libusb_hotplug_register_callback() and once
 * from libusb_handle_events(); and/or your callback may be called for the
 * removal of a device for which an arrived call was never made.
 *
 * Since version 1.0.16, \ref LIBUSBX_API_VERSION >= 0x01000102
 *
 * \param[in] ctx context to register this callback with
 * \param[in] events bitwise or of events that will trigger this callback. See \ref
 *            libusb_hotplug_event
 * \param[in] flags hotplug callback flags. See \ref libusb_hotplug_flag
 * \param[in] vendor_id the vendor id to match or \ref LIBUSB_HOTPLUG_MATCH_ANY
 * \param[in] product_id the product id to match or \ref LIBUSB_HOTPLUG_MATCH_ANY
 * \param[in] dev_class the device class to match or \ref LIBUSB_HOTPLUG_MATCH_ANY
 * \param[in] cb_fn the function to be invoked on a matching event/device
 * \param[in] user_data user data to pass to the callback function
 * \param[out] handle pointer to store the handle of the allocated callback (can be NULL)
 * \returns LIBUSB_SUCCESS on success LIBUSB_ERROR code on failure
 */
int libusb_hotplug_register_callback(libusb_context *ctx,
        libusb_hotplug_event events,
        libusb_hotplug_flag flags,
        int vendor_id, int product_id,
        int dev_class,
        libusb_hotplug_callback_fn cb_fn,
        void *user_data,
        libusb_hotplug_callback_handle *handle);

/** \ingroup hotplug
 * Deregisters a hotplug callback.
 *
 * Deregister a callback from a libusb_context. This function is safe to call from within
 * a hotplug callback.
 *
 * Since version 1.0.16, \ref LIBUSBX_API_VERSION >= 0x01000102
 *
 * \param[in] ctx context this callback is registered with
 * \param[in] handle the handle of the callback to deregister
 */
void libusb_hotplug_deregister_callback(libusb_context *ctx,
        libusb_hotplug_callback_handle handle);

}

