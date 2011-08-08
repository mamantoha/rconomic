require 'economic/entity'

module Economic

  # Represents a debtor contact.
  class DebtorContact < Entity
    has_properties :handle, :id, :debtor_handle, :name, :number, :telephone_number, :email, :comments, :external_id, :is_to_receive_email_copy_of_order, :is_to_receive_email_copy_of_invoice

    def debtor
      return nil if debtor_handle.blank?
      @debtor ||= session.debtors.find(debtor_handle[:number])
    end

    protected

    def build_soap_data
      data = ActiveSupport::OrderedHash.new

      data['Handle'] = { 'Id' => id }
      data['Id'] = id
      data['DebtorHandle'] = { 'Number' => debtor_handle[:number] } unless debtor_handle.blank?
      data['Name'] = name
      data['Number'] = number unless number.blank?
      data['TelephoneNumber'] = telephone_number unless telephone_number.blank?
      data['Email'] = email unless email.blank?
      data['Comments'] = comments unless comments.blank?
      data['ExternalId'] = external_id unless external_id.blank?
      data['IsToReceiveEmailCopyOfOrder'] = is_to_receive_email_copy_of_order || false
      data['IsToReceiveEmailCopyOfInvoice'] = is_to_receive_email_copy_of_invoice || false

      return data
    end

  end

end