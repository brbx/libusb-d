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

module funcs;

import consts;
import enums;
import structs;
core.stdc.limits : INT_MAX;
import core.sys.posix.sys.time : timeval;

extern (C):

libusb_transfer* libusb_alloc_transfer(int iso_packets);
int libusb_attach_kernel_driver(libusb_device_handle *dev, int interface_number);
int libusb_bulk_transfer(libusb_device_handle *dev_handle, char endpoint, char *data, int length, int *actual_length, uint timeout);
int libusb_cancel_transfer(libusb_transfer *transfer);
int libusb_claim_interface(libusb_device_handle *dev, int interface_number);
int libusb_clear_halt(libusb_device_handle *dev, char endpoint);
void libusb_close(libusb_device_handle *dev_handle);
int libusb_control_transfer(libusb_device_handle *dev_handle,ubyte request_type, ubyte bRequest, ushort wValue, ushort wIndex, char *data, ushort wLength, uint timeout);
int libusb_detach_kernel_driver(libusb_device_handle *dev, int interface_number);
char* libusb_error_name(int errcode);
int libusb_event_handler_active(libusb_context *ctx);
int libusb_event_handling_ok(libusb_context *ctx);
void libusb_exit(libusb_context *ctx);
void libusb_free_bos_descriptor(libusb_bos_descriptor *bos);
void libusb_free_config_descriptor(libusb_config_descriptor *config);
void libusb_free_container_id_descriptor(libusb_container_id_descriptor *container_id);
void libusb_free_device_list(libusb_device **list, int unref_devices);
void libusb_free_ss_endpoint_companion_descriptor(libusb_ss_endpoint_companion_descriptor *ep_comp);
void libusb_free_ss_usb_device_capability_descriptor(libusb_ss_usb_device_capability_descriptor *ss_usb_device_cap);
void libusb_free_transfer(libusb_transfer *transfer);
void libusb_free_usb_2_0_extension_descriptor(libusb_usb_2_0_extension_descriptor *usb_2_0_extension);
int libusb_get_active_config_descriptor(libusb_device *dev, libusb_config_descriptor **config);
int libusb_get_bos_descriptor(libusb_device_handle *handle, libusb_bos_descriptor **bos);
ubyte libusb_get_bus_number(libusb_device *dev);
int libusb_get_config_descriptor(libusb_device *dev, ubyte config_index, libusb_config_descriptor **config);
int libusb_get_config_descriptor_by_value(libusb_device *dev, ubyte bConfigurationValue, libusb_config_descriptor **config);
int libusb_get_configuration(libusb_device_handle *dev, int *config);
int libusb_get_container_id_descriptor(libusb_context *ctx, libusb_bos_dev_capability_descriptor *dev_cap, libusb_container_id_descriptor **container_id);
libusb_device* libusb_get_device(libusb_device_handle *dev_handle);
ubyte libusb_get_device_address(libusb_device *dev);
int libusb_get_device_descriptor(libusb_device *dev, libusb_device_descriptor *desc);
ptrdiff_t libusb_get_device_list(libusb_context *ctx, libusb_device ***list);
int libusb_get_device_speed(libusb_device *dev);
int libusb_get_max_iso_packet_size(libusb_device *dev, char endpoint);
int libusb_get_max_packet_size(libusb_device *dev, char endpoint);
int libusb_get_next_timeout(libusb_context *ctx, timeval *tv);
libusb_device* libusb_get_parent(libusb_device *dev);
libusb_pollfd** libusb_get_pollfds(libusb_context *ctx);
ubyte libusb_get_port_number(libusb_device *dev);
int libusb_get_port_numbers(libusb_device *dev, ubyte *port_numbers, int port_numbers_len);
int libusb_get_port_path(libusb_context *ctx, libusb_device *dev, ubyte *path, ubyte path_length);
int libusb_get_ss_endpoint_companion_descriptor(libusb_context *ctx, const libusb_endpoint_descriptor *endpoint, libusb_ss_endpoint_companion_descriptor **ep_comp);
int libusb_get_ss_usb_device_capability_descriptor(libusb_context *ctx,libusb_bos_dev_capability_descriptor *dev_cap, libusb_ss_usb_device_capability_descriptor **ss_usb_device_cap);
int libusb_get_string_descriptor_ascii(libusb_device_handle *dev, ubyte desc_index, char *data, int length);
int libusb_get_usb_2_0_extension_descriptor(libusb_context *ctx, libusb_bos_dev_capability_descriptor *dev_cap, libusb_usb_2_0_extension_descriptor **usb_2_0_extension);
libusb_version *libusb_get_version();
int libusb_handle_events(libusb_context *ctx);
int libusb_handle_events_completed(libusb_context *ctx, int *completed);
int libusb_handle_events_locked(libusb_context *ctx, timeval *tv);
int libusb_handle_events_timeout(libusb_context *ctx, timeval *tv);
int libusb_handle_events_timeout_completed(libusb_context *ctx, timeval *tv, int *completed);
int libusb_has_capability(uint capability);
void libusb_hotplug_deregister_callback(libusb_context *ctx, libusb_hotplug_callback_handle handle);
int libusb_hotplug_register_callback(libusb_context *ctx, libusb_hotplug_event events, libusb_hotplug_flag flags, int vendor_id, int product_id, int dev_class, libusb_hotplug_callback_fn cb_fn, void *user_data, libusb_hotplug_callback_handle *handle);

/** Initialize libusb */
int libusb_init(libusb_context **ctx);

int libusb_interrupt_transfer(libusb_device_handle *dev_handle, char endpoint, char *data, int length, int *actual_length, uint timeout);
int libusb_kernel_driver_active(libusb_device_handle *dev, int interface_number);
void libusb_lock_event_waiters(libusb_context *ctx);
void libusb_lock_events(libusb_context *ctx);
int libusb_open(libusb_device *dev, libusb_device_handle **handle);
libusb_device_handle* libusb_open_device_with_vid_pid(libusb_context *ctx, ushort vendor_id, ushort product_id);
int libusb_pollfds_handle_timeouts(libusb_context *ctx);
libusb_device* libusb_ref_device(libusb_device *dev);
int libusb_release_interface(libusb_device_handle *dev, int interface_number);
int libusb_reset_device(libusb_device_handle *dev);
int libusb_set_auto_detach_kernel_driver(libusb_device_handle *dev, int enable);
int libusb_set_configuration(libusb_device_handle *dev, int configuration);

/** Set log message verbosity */
void libusb_set_debug(libusb_context *ctx, int level);

int libusb_set_interface_alt_setting(libusb_device_handle *dev, int interface_number, int alternate_setting);
void libusb_set_pollfd_notifiers(libusb_context *ctx, libusb_pollfd_added_cb added_cb, libusb_pollfd_removed_cb removed_cb, void *user_data);
int libusb_setlocale(const char *locale);
char* libusb_strerror(int errcode);
int libusb_submit_transfer(libusb_transfer *transfer);
int libusb_try_lock_events(libusb_context *ctx);
void libusb_unlock_event_waiters(libusb_context *ctx);
void libusb_unlock_events(libusb_context *ctx);
void libusb_unref_device(libusb_device *dev);
int libusb_wait_for_event(libusb_context *ctx, timeval *tv);


/**
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
int libusb_get_descriptor(libusb_device_handle *dev, ubyte desc_type, ubyte desc_index, char *data, int length) {
  return libusb_control_transfer(dev, libusb_endpoint_direction.LIBUSB_ENDPOINT_IN,
                                 libusb_standard_request.LIBUSB_REQUEST_GET_DESCRIPTOR,
                                 cast(ushort)((desc_type << 8) | desc_index),
                                 0,
                                 data,
                                 cast(ushort)length, 1000);
}

/**
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
char *libusb_control_transfer_get_data(libusb_transfer *transfer) {
  return transfer.buffer + LIBUSB_CONTROL_SETUP_SIZE;
}

/**
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
libusb_control_setup *libusb_control_transfer_get_setup(libusb_transfer *transfer) {
  return cast(libusb_control_setup*)(cast(void *) transfer.buffer);
}

/**
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
void libusb_fill_control_setup(char *buffer, ubyte bmRequestType,
                                      ubyte bRequest, ushort wValue, ushort wIndex,
                                      ushort wLength) {
  libusb_control_setup *setup = cast(libusb_control_setup *)(cast(void *) buffer);
  setup.bmRequestType = bmRequestType;
  setup.bRequest = bRequest;
  setup.wValue = libusb_cpu_to_le16(wValue);
  setup.wIndex = libusb_cpu_to_le16(wIndex);
  setup.wLength = libusb_cpu_to_le16(wLength);
}

/**
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
int libusb_get_string_descriptor(libusb_device_handle *dev, ubyte desc_index, ushort langid, char *data, int length) {
  return libusb_control_transfer(dev, libusb_endpoint_direction.LIBUSB_ENDPOINT_IN,
                                 libusb_standard_request.LIBUSB_REQUEST_GET_DESCRIPTOR,
                                 cast(ushort)((libusb_descriptor_type.LIBUSB_DT_STRING << 8) | desc_index),
                                 langid,
                                 data,
                                 cast(ushort)length,
                                 1000);
}

/**
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
void libusb_fill_control_transfer(
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

/**
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
void libusb_fill_bulk_transfer(libusb_transfer *transfer,
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

/**
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
void libusb_fill_interrupt_transfer(
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

/**
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
void libusb_fill_iso_transfer(libusb_transfer *transfer,
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

/**
 * Convenience function to set the length of all packets in an isochronous
 * transfer, based on the num_iso_packets field in the transfer structure.
 *
 * \param transfer a transfer
 * \param length the length to set in each isochronous packet descriptor
 * \see libusb_get_max_packet_size()
 */
void libusb_set_iso_packet_lengths(libusb_transfer *transfer, uint length) {
    int i;
    for (i = 0; i < transfer.num_iso_packets; i++) {
      transfer.iso_packet_desc[i].length = length;
    }
}

/**
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
char *libusb_get_iso_packet_buffer(libusb_transfer *transfer, uint packet) {
    int i;
    size_t offset = 0;
    int _packet;

    /* oops..slight bug in the API. packet is an unsigned int, but we use
     * signed integers almost everywhere else. range-check and convert to
     * signed to avoid compiler warnings. FIXME for libusb-2. */
    if (packet > INT_MAX) { return null; }

    _packet = cast(int)packet;

    if (_packet >= transfer.num_iso_packets) { return null; }

    for (i = 0; i < _packet; i++) {
      offset += transfer.iso_packet_desc[i].length;
    }

    return transfer.buffer + offset;
}


/**
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
char *libusb_get_iso_packet_buffer_simple(libusb_transfer *transfer, uint packet) {
    int _packet;

    /* oops..slight bug in the API. packet is an unsigned int, but we use
     * signed integers almost everywhere else. range-check and convert to
     * signed to avoid compiler warnings. FIXME for libusb-2. */
    if (packet > INT_MAX)
    { return null; }

    _packet = cast(int)packet;

    if (_packet >= transfer.num_iso_packets) { return null; }

    return transfer.buffer + (cast(int)(transfer.iso_packet_desc[0].length * _packet));
}

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

alias libusb_transfer_cb_fn = void function(libusb_transfer *transfer);
alias libusb_pollfd_added_cb = void function(int fd, short events, void *user_data);
alias libusb_pollfd_removed_cb = void function(int fd, void *user_data);
alias libusb_hotplug_callback_handle = int;
alias libusb_hotplug_callback_fn = int function(libusb_context *ctx, libusb_device *device, libusb_hotplug_event event, void *user_data);
