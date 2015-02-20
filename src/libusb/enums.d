/**
 * Converted/butchered LIBUSB header to a D-Language interface
 *
 * Authors: Ross Lonstein <lonstein@brightboxcharge.com>
 * License: LGPL
 * Copyright: 2015, Brightbox, Inc.
 * See_Also: http://www.libusb.org
 * Notes: Libusb itself is Copyright
 * $(UL
 *   $(LI 2001 Johannes Erdfelt <johannes@erdfelt.com>)
 *   $(LI 2007-2008 Daniel Drake <dsd@gentoo.org>)
 *   $(LI 2012 Pete Batard <pete@akeo.ie>)
 *   $(LI 2012 Nathan Hjelm <hjelmn@cs.unm.edu>) )
 *
 */

module enums;

alias libusb_hotplug_flag = LIBUSB_HOTPLUG_ENUM;
alias libusb_hotplug_event = LIBUSB_HOTPLUG_EVENTS;

extern (C):

/**
 * Device and/or Interface Class codes
 */
enum libusb_class_code : ubyte {
  LIBUSB_CLASS_PER_INTERFACE       = 0,
  LIBUSB_CLASS_AUDIO               = 1,     /** Audio class */
  LIBUSB_CLASS_COMM                = 2,     /** Communications class */
  LIBUSB_CLASS_HID                 = 3,     /** Human Interface Device class */
  LIBUSB_CLASS_PHYSICAL            = 5,     /** Physical */
  LIBUSB_CLASS_PRINTER             = 7,     /** Printer class */
  LIBUSB_CLASS_PTP                 = 6,     /** legacy name from libusb-0.1 usb.h */
  LIBUSB_CLASS_IMAGE               = 6,     /** Image class */
  LIBUSB_CLASS_MASS_STORAGE        = 8,     /** Mass storage class */
  LIBUSB_CLASS_HUB                 = 9,     /** Hub class */
  LIBUSB_CLASS_DATA                = 10,    /** Data class */
  LIBUSB_CLASS_SMART_CARD          = 0x0b,  /** Smart Card */
  LIBUSB_CLASS_CONTENT_SECURITY    = 0x0d,  /** Content Security */
  LIBUSB_CLASS_VIDEO               = 0x0e,  /** Video */
  LIBUSB_CLASS_PERSONAL_HEALTHCARE = 0x0f,  /** Personal Healthcare */
  LIBUSB_CLASS_DIAGNOSTIC_DEVICE   = 0xdc,  /** Diagnostic Device */
  LIBUSB_CLASS_WIRELESS            = 0xe0,  /** Wireless class */
  LIBUSB_CLASS_APPLICATION         = 0xfe,  /** Application class */
  LIBUSB_CLASS_VENDOR_SPEC         = 0xff   /** Class is vendor-specific */
};


/**
 * Descriptor types as defined by the USB specification.
 */
enum libusb_descriptor_type : ubyte {
  LIBUSB_DT_DEVICE                = 0x01, /** Device descriptor. See libusb_device_descriptor. */
  LIBUSB_DT_CONFIG                = 0x02, /** Configuration descriptor. See libusb_config_descriptor. */
  LIBUSB_DT_STRING                = 0x03, /** String descriptor  */
  LIBUSB_DT_INTERFACE             = 0x04, /** Interface descriptor. See libusb_interface_descriptor. */
  LIBUSB_DT_ENDPOINT              = 0x05, /** Endpoint descriptor. See libusb_endpoint_descriptor. */
  LIBUSB_DT_BOS                   = 0x0f, /** BOS descriptor  */
  LIBUSB_DT_DEVICE_CAPABILITY     = 0x10, /** Device Capability descriptor */
  LIBUSB_DT_HID                   = 0x21, /** HID descriptor */
  LIBUSB_DT_REPORT                = 0x22, /** HID report descriptor */
  LIBUSB_DT_PHYSICAL              = 0x23, /** Physical descriptor */
  LIBUSB_DT_HUB                   = 0x29, /** Hub descriptor */
  LIBUSB_DT_SUPERSPEED_HUB        = 0x2a, /** SuperSpeed Hub descriptor */
  LIBUSB_DT_SS_ENDPOINT_COMPANION = 0x30  /** SuperSpeed Endpoint Companion descriptor */
};


/**
 * Endpoint direction. Values for bit 7 of the
 * libusb_endpoint_descriptor::bEndpointAddress "endpoint address" scheme.
 */
enum libusb_endpoint_direction : ubyte {
  LIBUSB_ENDPOINT_IN  = 0x80,    /** In:  device-to-host */
  LIBUSB_ENDPOINT_OUT = 0x00     /** Out: host-to-device */
};


/**
 * Endpoint transfer type. Values for bits 0:1 of the
 * libusb_endpoint_descriptor::bmAttributes "endpoint attributes" field.
 */
enum libusb_transfer_type : ubyte {
  LIBUSB_TRANSFER_TYPE_CONTROL     = 0,   /** Control endpoint */
  LIBUSB_TRANSFER_TYPE_ISOCHRONOUS = 1,   /** Isochronous endpoint */
  LIBUSB_TRANSFER_TYPE_BULK        = 2,   /** Bulk endpoint */
  LIBUSB_TRANSFER_TYPE_INTERRUPT   = 3    /** Interrupt endpoint */
};


/**
 * Standard requests, as defined in table 9-5 of the USB 3.0 specifications
 */
enum libusb_standard_request {
  LIBUSB_REQUEST_GET_STATUS        = 0x00, /** Request status of the specific recipient */
  LIBUSB_REQUEST_CLEAR_FEATURE     = 0x01, /** Clear or disable a specific feature */
  /* 0x02 is reserved */
  LIBUSB_REQUEST_SET_FEATURE       = 0x03, /** Set or enable a specific feature */
  /* 0x04 is reserved */
  LIBUSB_REQUEST_SET_ADDRESS       = 0x05, /** Set device address for all future accesses */
  LIBUSB_REQUEST_GET_DESCRIPTOR    = 0x06, /** Get the specified descriptor */
  LIBUSB_REQUEST_SET_DESCRIPTOR    = 0x07, /** Used to update existing descriptors or add new descriptors */
  LIBUSB_REQUEST_GET_CONFIGURATION = 0x08, /** Get the current device configuration value */
  LIBUSB_REQUEST_SET_CONFIGURATION = 0x09, /** Set device configuration */
  LIBUSB_REQUEST_GET_INTERFACE     = 0x0A, /** Return the selected alternate setting for the specified interface */
  LIBUSB_REQUEST_SET_INTERFACE     = 0x0B, /** Select an alternate interface for the specified interface */
  LIBUSB_REQUEST_SYNCH_FRAME       = 0x0C, /** Set then report an endpoint's synchronization frame */
  LIBUSB_REQUEST_SET_SEL           = 0x30, /** Sets both the U1 and U2 Exit Latency */
  LIBUSB_SET_ISOCH_DELAY           = 0x31, /** Delay from the time a host transmits a packet to the time it is received by the device. */
};


/**
 * Request type bits of the libusb_control_setup::bmRequestType
 * "bmRequestType" field in control transfers. 
 */
enum libusb_request_type : ubyte {
  LIBUSB_REQUEST_TYPE_STANDARD = (0x00 << 5),   /** Standard */
  LIBUSB_REQUEST_TYPE_CLASS    = (0x01 << 5),   /** Class */
  LIBUSB_REQUEST_TYPE_VENDOR   = (0x02 << 5),   /** Vendor */
  LIBUSB_REQUEST_TYPE_RESERVED = (0x03 << 5)    /** Reserved */
};


/**
 * Recipient bits of the
 * libusb_control_setup::bmRequestType "bmRequestType" field in control
 * transfers. Values 4 through 31 are reserved. */
enum libusb_request_recipient {
  LIBUSB_RECIPIENT_DEVICE    = 0x00,  /** Device */
  LIBUSB_RECIPIENT_INTERFACE = 0x01,  /** Interface */
  LIBUSB_RECIPIENT_ENDPOINT  = 0x02,  /** Endpoint */
  LIBUSB_RECIPIENT_OTHER     = 0x03,  /** Other */
};


/**
 * Synchronization type for isochronous endpoints. Values for bits 2:3 of the
 * libusb_endpoint_descriptor::bmAttributes "bmAttributes" field in
 * libusb_endpoint_descriptor.
 */
enum libusb_iso_sync_type {
  LIBUSB_ISO_SYNC_TYPE_NONE     = 0,  /** No synchronization */
  LIBUSB_ISO_SYNC_TYPE_ASYNC    = 1,  /** Asynchronous */
  LIBUSB_ISO_SYNC_TYPE_ADAPTIVE = 2,  /** Adaptive */
  LIBUSB_ISO_SYNC_TYPE_SYNC     = 3   /** Synchronous */
};


/**
 * Usage type for isochronous endpoints. Values for bits 4:5 of the
 * libusb_endpoint_descriptor::bmAttributes "bmAttributes" field in
 * libusb_endpoint_descriptor.
 */
enum libusb_iso_usage_type {
    LIBUSB_ISO_USAGE_TYPE_DATA     = 0,  /** Data endpoint */
    LIBUSB_ISO_USAGE_TYPE_FEEDBACK = 1,  /** Feedback endpoint */
    LIBUSB_ISO_USAGE_TYPE_IMPLICIT = 2,  /** Implicit feedback Data endpoint */
};


/**
 * Speed codes. Indicates the speed at which the device is operating.
 */
enum libusb_speed {
    LIBUSB_SPEED_UNKNOWN = 0,
    LIBUSB_SPEED_LOW     = 1,  /** low speed (1.5MBit/s). */
    LIBUSB_SPEED_FULL    = 2,  /** full speed (12MBit/s). */
    LIBUSB_SPEED_HIGH    = 3,  /** high speed (480MBit/s). */
    LIBUSB_SPEED_SUPER   = 4,  /** super speed (5000MBit/s). */
};


/**
 * Supported speeds (wSpeedSupported) bitfield. Indicates what
 * speeds the device supports.
 */
enum libusb_supported_speed {
    LIBUSB_LOW_SPEED_OPERATION   = 1,  /** Low speed  supported (1.5MBit/s). */
    LIBUSB_FULL_SPEED_OPERATION  = 2,  /** Full speed supported (12MBit/s). */
    LIBUSB_HIGH_SPEED_OPERATION  = 4,  /** High speed supported (480MBit/s). */
    LIBUSB_SUPER_SPEED_OPERATION = 8,  /** Superspeed supported (5000MBit/s). */
};


/**
 * Masks for the bits of the
 * libusb_usb_2_0_extension_descriptor::bmAttributes "bmAttributes" field
 * of the USB 2.0 Extension descriptor.
 */
enum libusb_usb_2_0_extension_attributes {
    LIBUSB_BM_LPM_SUPPORT = 2,    /** Supports Link Power Management (LPM) */
};


/**
 * Masks for the bits of the
 * libusb_ss_usb_device_capability_descriptor::bmAttributes "bmAttributes" field
 * field of the SuperSpeed USB Device Capability descriptor.
 */
enum libusb_ss_usb_device_capability_attributes {
    LIBUSB_BM_LTM_SUPPORT = 2,    /** Supports Latency Tolerance Messages (LTM) */
};


/**
 * USB capability types
 */
enum libusb_bos_type {
    LIBUSB_BT_WIRELESS_USB_DEVICE_CAPABILITY = 1,    /** Wireless USB device capability */
    LIBUSB_BT_USB_2_0_EXTENSION              = 2,    /** USB 2.0 extensions */
    LIBUSB_BT_SS_USB_DEVICE_CAPABILITY       = 3,    /** SuperSpeed USB device capability */
    LIBUSB_BT_CONTAINER_ID                   = 4,    /** Container ID type */
};


/**
 * Error codes. Most libusbx functions return 0 on success or one of these
 * codes on failure.
 *
 * You can call libusb_error_name() to retrieve a string representation of an
 * error code or libusb_strerror() to get an end-user suitable description of
 * an error code.
 */
enum libusb_error : int {
  LIBUSB_SUCCESS             =  0,  /** Success (no error) */
  LIBUSB_ERROR_IO            = -1,  /** Input/output error */
  LIBUSB_ERROR_INVALID_PARAM = -2,  /** Invalid parameter */
  LIBUSB_ERROR_ACCESS        = -3,  /** Access denied (insufficient permissions) */
  LIBUSB_ERROR_NO_DEVICE     = -4,  /** No such device (it may have been disconnected) */
  LIBUSB_ERROR_NOT_FOUND     = -5,  /** Entity not found */
  LIBUSB_ERROR_BUSY          = -6,  /** Resource busy */
  LIBUSB_ERROR_TIMEOUT       = -7,  /** Operation timed out */
  LIBUSB_ERROR_OVERFLOW      = -8,  /** Overflow */
  LIBUSB_ERROR_PIPE          = -9,  /** Pipe error */
  LIBUSB_ERROR_INTERRUPTED   = -10, /** System call interrupted */
  LIBUSB_ERROR_NO_MEM        = -11, /** Insufficient memory */
  LIBUSB_ERROR_NOT_SUPPORTED = -12, /** Operation not supported or unimplemented on this platform */
  LIBUSB_ERROR_OTHER         = -99
};


/**
 * Transfer status codes */
enum libusb_transfer_status {
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


/**
 * libusb_transfer.flags values */
enum libusb_transfer_flags {
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


/**
 * Capabilities supported by an instance of libusb on the current running
 * platform. Test if the loaded library supports a given capability by calling
 * libusb_has_capability().
 */
enum libusb_capability {
  LIBUSB_CAP_HAS_CAPABILITY = 0x0000, /** The libusb_has_capability() API is available. */
  LIBUSB_CAP_HAS_HOTPLUG    = 0x0001, /** Hotplug support is available on this platform. */
  LIBUSB_CAP_HAS_HID_ACCESS = 0x0100, /** The library can access HID devices without requiring user intervention.
                                       *
                                       * Note that before being able to actually access an HID device, you may
                                       * still have to call additional libusbx functions such as
                                       * libusb_detach_kernel_driver(). */
  LIBUSB_CAP_SUPPORTS_DETACH_KERNEL_DRIVER = 0x0101 /** The library supports detaching of the default USB driver, using
                                                     * libusb_detach_kernel_driver(), if one is set by the OS kernel */
};

/**
 *  Log message levels.
 *
 * $(UL
 *  $(LI LIBUSB_LOG_LEVEL_NONE (0)    : no messages ever printed by the library (default))
 *  $(LI LIBUSB_LOG_LEVEL_ERROR (1)   : error messages are printed to stderr)
 *  $(LI LIBUSB_LOG_LEVEL_WARNING (2) : warning and error messages are printed to stderr)
 *  $(LI LIBUSB_LOG_LEVEL_INFO (3)    : informational messages are printed to stdout, warning
 *    and error messages are printed to stderr)
 *  $(LI LIBUSB_LOG_LEVEL_DEBUG (4)   : debug and informational messages are printed to stdout,
 *    warnings and errors to stderr)
 * )
 */
enum libusb_log_level {
    LIBUSB_LOG_LEVEL_NONE = 0,
    LIBUSB_LOG_LEVEL_ERROR,
    LIBUSB_LOG_LEVEL_WARNING,
    LIBUSB_LOG_LEVEL_INFO,
    LIBUSB_LOG_LEVEL_DEBUG,
};


/**
 * Flags for hotplug events
 *
 * Since version 1.0.16, LIBUSBX_API_VERSION >= 0x01000102
 */
enum LIBUSB_HOTPLUG_ENUM {
    /** Arm the callback and fire it for all matching currently attached devices. */
    LIBUSB_HOTPLUG_ENUMERATE = 1,
};


/**
 * Hotplug events
 *
 * Since version 1.0.16, LIBUSBX_API_VERSION >= 0x01000102
 *
 */
enum LIBUSB_HOTPLUG_EVENTS {
  /** A device has been plugged in and is ready to use */
  LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED = 0x01,

  /** A device has left and is no longer available.
   * It is the user's responsibility to call libusb_close on any handle associated with a disconnected device.
   * It is safe to call libusb_get_device_descriptor on a device that has left */
  LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT    = 0x02,
};
