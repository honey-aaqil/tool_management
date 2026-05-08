import React, { useState, useEffect } from 'react';
import api from '../../services/api';

const ToolManagement = () => {
  const [tools, setTools] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [editingTool, setEditingTool] = useState(null);
  const [filterStatus, setFilterStatus] = useState('All');
  const [showExpiringModal, setShowExpiringModal] = useState(false);
  const [showRenewedModal, setShowRenewedModal] = useState(false);
  const [formData, setFormData] = useState({
    tool_name: '',
    year: new Date().getFullYear(),
    no_of_license: 1,
    type: 'NA',
    cost: 0,
    revenue: 0,
    monthly_cost: 0,
    quarterly_cost: 0,
    annual_cost: 0,
    currency: 'USD',
    geography: 'INDIA',
    job_slots: 0,
    resume_views: 0,
    bulk_mail: 0,
    payment_frequency: 'Monthly',
    last_renewal: '',
    next_renewal: '',
    comments: '',
    spoc_1: '',
    spoc_2: '',
    contact_no: '',
    email_id: '',
    status: 'Active',
    reason_for_using: '',
  });

  const currencySymbols = {
    'INR': '₹',
    'USD': '$',
    'CAD': '$',
    'MYR': 'RM',
    'AED': 'د.إ',
    'EUR': '€',
    'GBP': '£'
  };

  const getCurrencySymbol = (currency) => currencySymbols[currency] || '$';

  const [currentPage, setCurrentPage] = useState(1);
  const [rowsPerPage] = useState(50);
  const [pagination, setPagination] = useState({ page: 1, limit: 50, total: 0, totalPages: 0 });

  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isAdmin = user && (user.admin_access === true || user.admin_access === 1);

  useEffect(() => {
    fetchTools();
  }, []);

  const fetchTools = async (page = 1, status = null) => {
    try {
      setLoading(true);
      const statusToUse = status !== null ? status : filterStatus;
      const data = await api.getTools(page, rowsPerPage, statusToUse);
      setTools(data.tools || []);
      if (data.pagination) {
        setPagination(data.pagination);
      } else {
        setPagination({ page: 1, limit: rowsPerPage, total: (data.tools || []).length, totalPages: 1 });
      }
    } catch (err) {
      setError(err.message);
      setTools([]);
      setPagination({ page: 1, limit: rowsPerPage, total: 0, totalPages: 0 });
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (e) => {
    const newStatus = e.target.value;
    setFilterStatus(newStatus);
    setCurrentPage(1);
    fetchTools(1, newStatus);
  };

  const filteredTools = tools;

  const handlePageChange = async (pageNumber) => {
    setCurrentPage(pageNumber);
    fetchTools(pageNumber, null);
  };

  const sanitizeCSVField = (field) => {
    const str = String(field || '');
    // If field starts with formula character, prefix with single quote
    if (/^[=+\-@\t]/.test(str)) {
      return "'" + str;
    }
    // Escape double quotes
    return str.replace(/"/g, '""');
  };

  const handleExportCSV = () => {
    const headers = [
      'Year', 'Tool Name', 'Type', 'No. of License', 'Resume Views',
      'Job Slots', 'Bulk Mail', 'Cost', 'Monthly Cost', 'Quarterly Cost',
      'Annual Cost', 'Currency', 'Payment Frequency', 'Last Renewal', 'Next Renewal',
      'Comments', 'SPOC Internal', 'SPOC External', 'Contact No.', 'Email ID', 'Status'
    ];
    
    const csvContent = [
      headers.join(','),
      ...tools.map(tool => [
        sanitizeCSVField(tool.year),
        sanitizeCSVField(tool.tool_name),
        sanitizeCSVField(tool.type),
        sanitizeCSVField(tool.no_of_license),
        sanitizeCSVField(tool.resume_views),
        sanitizeCSVField(tool.job_slots),
        sanitizeCSVField(tool.bulk_mail || 0),
        sanitizeCSVField(getCurrencySymbol(tool.currency) + tool.cost),
        sanitizeCSVField(getCurrencySymbol(tool.currency) + tool.monthly_cost),
        sanitizeCSVField(getCurrencySymbol(tool.currency) + tool.quarterly_cost),
        sanitizeCSVField(getCurrencySymbol(tool.currency) + tool.annual_cost),
        sanitizeCSVField(tool.currency),
        sanitizeCSVField(tool.payment_frequency),
        sanitizeCSVField(tool.last_renewal),
        sanitizeCSVField(tool.next_renewal),
        sanitizeCSVField(tool.comments),
        sanitizeCSVField(tool.spoc_1),
        sanitizeCSVField(tool.spoc_2),
        sanitizeCSVField(tool.contact_no),
        sanitizeCSVField(tool.email_id),
        sanitizeCSVField(tool.status)
      ].join(','))
    ].join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'tools_export.csv';
    a.click();
  };

  const getExpiringTools = () => {
    return tools.filter(tool => {
      if (!tool.next_renewal || tool.status !== 'Active') return false;
      const daysLeft = getDaysLeft(tool.next_renewal);
      return daysLeft >= 0 && daysLeft <= 31;
    });
  };

  const getDaysLeft = (renewalDate) => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const renewal = new Date(renewalDate);
    renewal.setHours(0, 0, 0, 0);
    const diffTime = renewal - today;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
  };

  const getRenewedTools = () => {
    const now = new Date();
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
    return tools.filter(tool => {
      if (!tool.last_renewal) return false;
      const lastRenewal = new Date(tool.last_renewal);
      return lastRenewal >= startOfMonth && tool.status === 'Active';
    });
  };

  const handleAdd = () => {
    setEditingTool(null);
    setFormData({
      tool_name: '',
      year: new Date().getFullYear(),
      no_of_license: '',
      type: 'NA',
      cost: '',
      revenue: '',
      monthly_cost: '',
      quarterly_cost: '',
      annual_cost: '',
      currency: 'USD',
      geography: 'INDIA',
      job_slots: '',
      resume_views: '',
      bulk_mail: '',
      payment_frequency: 'Monthly',
      last_renewal: '',
      next_renewal: '',
      comments: '',
      spoc_1: '',
      spoc_2: '',
      contact_no: '',
      email_id: '',
      status: 'Active',
      reason_for_using: '',
    });
    setShowModal(true);
  };

  const handleEdit = (tool) => {
    setEditingTool(tool);
    setFormData({
      tool_name: tool.tool_name || '',
      year: tool.year || new Date().getFullYear(),
      no_of_license: tool.no_of_license ?? '',
      type: tool.type || 'NA',
      cost: tool.cost ?? '',
      revenue: tool.revenue ?? '',
      monthly_cost: tool.monthly_cost ?? '',
      quarterly_cost: tool.quarterly_cost ?? '',
      annual_cost: tool.annual_cost ?? '',
      currency: tool.currency || 'USD',
      geography: tool.geography || 'INDIA',
      job_slots: tool.job_slots ?? '',
      resume_views: tool.resume_views ?? '',
      bulk_mail: tool.bulk_mail ?? '',
      payment_frequency: tool.payment_frequency || 'Monthly',
      last_renewal: tool.last_renewal || '',
      next_renewal: tool.next_renewal || '',
      comments: tool.comments || '',
      spoc_1: tool.spoc_1 || '',
      spoc_2: tool.spoc_2 || '',
      contact_no: tool.contact_no || '',
      email_id: tool.email_id || '',
      status: tool.status || 'Active',
      reason_for_using: tool.reason_for_using || '',
    });
    setShowModal(true);
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this tool?')) return;
    try {
      await api.deleteTool(id);
      api.triggerToolRefresh();
      fetchTools(currentPage, filterStatus);
    } catch (err) {
      alert(err.message);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const formDataToSend = { ...formData };
      Object.keys(formDataToSend).forEach(key => {
        if (formDataToSend[key] === '') {
          formDataToSend[key] = null;
        }
      });
      
      if (editingTool) {
        await api.updateTool({ ...formDataToSend, id: editingTool.id });
      } else {
        await api.addTool(formDataToSend);
      }
      api.triggerToolRefresh();
      setShowModal(false);
      fetchTools(currentPage, filterStatus);
    } catch (err) {
      alert(err.message);
    }
  };

  const handleInputChange = (e) => {
    const { name, value, type } = e.target;
    
    if (type === 'number') {
      if (value === '' || value === '-') {
        setFormData((prev) => ({ ...prev, [name]: '' }));
        return;
      }
      const numValue = parseFloat(value);
      if (isNaN(numValue) || numValue < 0) return;
      setFormData((prev) => ({ ...prev, [name]: numValue }));
      return;
    }
    
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  return (
    <div className="tool-management">
      <div className="tool-header">
        <h1>Tool Archive</h1>
        <div className="tool-header-actions">
          <div className="summary-cards-inline">
            <div className="summary-card-small renewed" onClick={() => setShowRenewedModal(true)}>
              <div className="summary-icon renewed">
                <i className="fas fa-check-circle"></i>
              </div>
              <div className="summary-card-content">
                <span className="summary-label">Renewed</span>
                <span className="summary-count">{getRenewedTools().length}</span>
              </div>
            </div>
            <div className="summary-card-small expiring" onClick={() => setShowExpiringModal(true)}>
              <div className="summary-icon expiring">
                <i className="fas fa-exclamation-triangle"></i>
              </div>
              <div className="summary-card-content">
                <span className="summary-label">Expiring</span>
                <span className="summary-count">{getExpiringTools().length}</span>
              </div>
            </div>
          </div>
          {isAdmin && (
          <button onClick={handleAdd} className="btn-primary">
            <i className="fas fa-plus-circle"></i> Add New Tool
          </button>
          )}
        </div>
      </div>

      <div className="tool-filters">
          <div className="filter-group">
            <label><i className="fas fa-filter"></i> Filter Status:</label>
            <select value={filterStatus} onChange={handleFilterChange}>
              <option value="All">All Status</option>
              <option value="Active">Active Only</option>
              <option value="Inactive">Inactive Only</option>
            </select>
          </div>
          <button onClick={handleExportCSV} className="btn-export">
            <i className="fas fa-file-export"></i> Export to CSV
          </button>
        </div>

      {showExpiringModal && (
        <div className="modal-overlay" onClick={() => setShowExpiringModal(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h2><i className="fas fa-calendar-exclamation"></i> Tools Expiring This Month</h2>
              <button className="modal-close" onClick={() => setShowExpiringModal(false)}>×</button>
            </div>
            <div className="modal-body">
              {getExpiringTools().length === 0 ? (
                <p className="no-data">No tools expiring this month</p>
              ) : (
                <table className="expiring-table">
                  <thead>
                    <tr>
                      <th>Tool Name</th>
                      <th>Type</th>
                      <th>Cost</th>
                      <th>Renewal Date</th>
                      <th>Days Left</th>
                    </tr>
                  </thead>
                  <tbody>
                    {getExpiringTools().map(tool => (
                      <tr key={tool.id}>
                        <td><strong>{tool.tool_name}</strong></td>
                        <td>{tool.type}</td>
                        <td>{getCurrencySymbol(tool.currency)}{parseFloat(tool.cost || 0).toLocaleString()}</td>
                        <td>{tool.next_renewal}</td>
                        <td><span className="days-badge">{getDaysLeft(tool.next_renewal)} days</span></td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </div>
      )}

      {showRenewedModal && (
        <div className="modal-overlay" onClick={() => setShowRenewedModal(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h2><i className="fas fa-check-circle"></i> Tools Renewed This Month</h2>
              <button className="modal-close" onClick={() => setShowRenewedModal(false)}>×</button>
            </div>
            <div className="modal-body">
              {getRenewedTools().length === 0 ? (
                <p className="no-data">No tools renewed this month</p>
              ) : (
                <table className="expiring-table">
                  <thead>
                    <tr>
                      <th>Tool Name</th>
                      <th>Type</th>
                      <th>Cost</th>
                      <th>Renewed Date</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    {getRenewedTools().map(tool => (
                      <tr key={tool.id}>
                        <td><strong>{tool.tool_name}</strong></td>
                        <td>{tool.type}</td>
                        <td>{getCurrencySymbol(tool.currency)}{parseFloat(tool.cost || 0).toLocaleString()}</td>
                        <td>{tool.last_renewal}</td>
                        <td><span className="status-badge active">{tool.status}</span></td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </div>
      )}

      {error && <div className="error-message">{error}</div>}

      {loading ? (
        <p>Loading...</p>
      ) : (
        <>
          <div className="table-container">
            <table className="tool-table">
              <thead>
                <tr>
                  <th>Year</th>
                  <th>Tool Name</th>
                  <th>Type</th>
                  <th>Geography</th>
                  <th>License</th>
                  <th>Job Slot</th>
                  <th>Resume View</th>
                  <th>Bulk Mail</th>
                  <th>Cost</th>
                  <th>Monthly Cost</th>
                  <th>Quarterly Cost</th>
                  <th>Annual Cost</th>
                  <th>Currency</th>
                  <th>Frequency</th>
                  <th>Last Renewal</th>
                  <th>Next Renewal</th>
                  <th>Comments</th>
                  <th>SPOC 1</th>
                  <th>SPOC 2</th>
                  <th>Contact No</th>
                  <th>Email</th>
                  <th>Status</th>
                  <th className="action-header-cell">Edit</th>
                  <th className="action-header-cell">Delete</th>
                </tr>
              </thead>
              <tbody>
                {tools.map((tool) => (
                  <tr key={tool.id}>
                    <td>{tool.year}</td>
                    <td><strong>{tool.tool_name}</strong></td>
                    <td>{tool.type || 'NA'}</td>
                    <td>{tool.geography || '-'}</td>
                    <td>{tool.no_of_license || '-'}</td>
                    <td>{tool.job_slots != null && tool.job_slots > 0 ? tool.job_slots : '-'}</td>
                    <td>{tool.resume_views != null && tool.resume_views > 0 ? tool.resume_views : '-'}</td>
                    <td>{tool.bulk_mail == 1 ? 'Yes' : (tool.bulk_mail > 0 ? 'Yes' : 'No')}</td>
                    <td>{getCurrencySymbol(tool.currency)}{Number(tool.cost || 0).toLocaleString()}</td>
                    <td>{getCurrencySymbol(tool.currency)}{Number(tool.monthly_cost || 0).toLocaleString()}</td>
                    <td>{getCurrencySymbol(tool.currency)}{Number(tool.quarterly_cost || 0).toLocaleString()}</td>
                    <td>{getCurrencySymbol(tool.currency)}{Number(tool.annual_cost || 0).toLocaleString()}</td>
                    <td>{tool.currency || 'USD'}</td>
                    <td>{tool.payment_frequency || '-'}</td>
                    <td>{tool.last_renewal || '-'}</td>
                    <td>{tool.next_renewal || '-'}</td>
                    <td>{tool.comments || '-'}</td>
                    <td>{tool.spoc_1 || '-'}</td>
                    <td>{tool.spoc_2 || '-'}</td>
                    <td>{tool.contact_no || '-'}</td>
                    <td>{tool.email_id || '-'}</td>
                    <td>
                      <span className={`status status-${tool.status?.toLowerCase()}`}>
                        {tool.status}
                      </span>
                    </td>
                    <td className="action-cell-edit">
                      {isAdmin && (
                      <button onClick={() => handleEdit(tool)} className="btn-edit" title="Edit">
                        <i className="fas fa-edit"></i>
                      </button>
                      )}
                    </td>
                    <td className="action-cell-delete">
                      {isAdmin && (
                      <button
                        onClick={() => handleDelete(tool.id)}
                        className="btn-delete"
                        title="Delete"
                      >
                        <i className="fas fa-trash"></i>
                      </button>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {pagination.totalPages > 1 && (
            <div className="pagination-container">
              <div className="pagination-info">
                Showing {((pagination.page - 1) * rowsPerPage) + 1} to {Math.min(pagination.page * rowsPerPage, pagination.total)} of {pagination.total} entries
              </div>
              <div className="pagination">
                <button 
                  onClick={() => handlePageChange(1)} 
                  disabled={pagination.page === 1}
                  className="page-btn"
                >
                  <i className="fas fa-angle-double-left"></i>
                </button>
                <button 
                  onClick={() => handlePageChange(pagination.page - 1)} 
                  disabled={pagination.page === 1}
                  className="page-btn"
                >
                  <i className="fas fa-angle-left"></i>
                </button>
                
                {Array.from({ length: Math.min(5, pagination.totalPages) }, (_, i) => {
                  let pageNum;
                  if (pagination.totalPages <= 5) {
                    pageNum = i + 1;
                  } else if (pagination.page <= 3) {
                    pageNum = i + 1;
                  } else if (pagination.page >= pagination.totalPages - 2) {
                    pageNum = pagination.totalPages - 4 + i;
                  } else {
                    pageNum = pagination.page - 2 + i;
                  }
                  return (
                    <button
                      key={pageNum}
                      onClick={() => handlePageChange(pageNum)}
                      className={`page-btn ${pagination.page === pageNum ? 'active' : ''}`}
                    >
                      {pageNum}
                    </button>
                  );
                })}

                <button 
                  onClick={() => handlePageChange(pagination.page + 1)} 
                  disabled={pagination.page === pagination.totalPages}
                  className="page-btn"
                >
                  <i className="fas fa-angle-right"></i>
                </button>
                <button 
                  onClick={() => handlePageChange(pagination.totalPages)} 
                  disabled={pagination.page === pagination.totalPages}
                  className="page-btn"
                >
                  <i className="fas fa-angle-double-right"></i>
                </button>
              </div>
            </div>
          )}
        </>
      )}

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal-fullscreen" onClick={(e) => e.stopPropagation()}>
            <div className="modal-fullscreen-header">
              <h2><i className={`fas ${editingTool ? 'fa-edit' : 'fa-plus-circle'}`}></i> {editingTool ? 'Edit Tool' : 'Add New Tool'}</h2>
              <button className="modal-close" onClick={() => setShowModal(false)}><i className="fas fa-times"></i></button>
            </div>
            <form onSubmit={handleSubmit} className="modal-fullscreen-form">
              <div className="form-section">
                <h3>Basic Information</h3>
                <div className="form-row">
                  <div className="form-group">
                    <label>Year *</label>
                    <input type="number" name="year" value={formData.year} onChange={handleInputChange} min="2000" max="2100" />
                  </div>
                  <div className="form-group">
                    <label>Tool Name *</label>
                    <input type="text" name="tool_name" value={formData.tool_name} onChange={handleInputChange} required placeholder="Enter tool name" />
                  </div>
                  <div className="form-group">
                    <label>Type</label>
                    <select name="type" value={formData.type} onChange={handleInputChange}>
                      <option value="Job Portal">Job Portal</option>
                      <option value="Development">Development</option>
                      <option value="Resume Sourcing">Resume Sourcing</option>
                      <option value="Analytics">Analytics</option>
                      <option value="Communication">Communication</option>
                      <option value="Storage">Storage</option>
                      <option value="Security">Security</option>
                      <option value="Both">Both</option>
                      <option value="NA">NA</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label>Geography</label>
                    <select name="geography" value={formData.geography} onChange={handleInputChange}>
                      <option value="USA">USA</option>
                      <option value="INDIA">INDIA</option>
                      <option value="CANADA">CANADA</option>
                      <option value="MALAYSIA">MALAYSIA</option>
                      <option value="DUBAI">DUBAI</option>
                      <option value="UK">UK</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label>No. of License</label>
                    <input type="number" name="no_of_license" value={formData.no_of_license} onChange={handleInputChange} min="1" />
                  </div>
                  <div className="form-group">
                    <label>Status</label>
                    <select name="status" value={formData.status} onChange={handleInputChange}>
                      <option value="Active">Active</option>
                      <option value="Inactive">Inactive</option>
                    </select>
                  </div>
                </div>
              </div>

              <div className="form-section">
                <h3>Usage Statistics</h3>
                <div className="form-row">
                  <div className="form-group">
                    <label>Job Slots</label>
                    <input type="number" name="job_slots" value={formData.job_slots} onChange={handleInputChange} min="0" placeholder="0" />
                  </div>
                  <div className="form-group">
                    <label>Resume Views</label>
                    <input type="number" name="resume_views" value={formData.resume_views} onChange={handleInputChange} min="0" placeholder="0" />
                  </div>
                  <div className="form-group">
                    <label>Bulk Mail</label>
                    <input type="number" name="bulk_mail" value={formData.bulk_mail} onChange={handleInputChange} min="0" placeholder="0" />
                  </div>
                </div>
              </div>

              <div className="form-section">
                <h3>Financial Details</h3>
                <div className="form-row">
                  <div className="form-group">
                    <label>Currency</label>
                    <select name="currency" value={formData.currency} onChange={handleInputChange}>
                      <option value="USD">USD</option>
                      <option value="CAD">CAD</option>
                      <option value="INR">INR</option>
                      <option value="MYR">MYR</option>
                      <option value="AED">AED</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label>Cost</label>
                    <input type="number" name="cost" value={formData.cost} onChange={handleInputChange} step="0.01" placeholder="0.00" />
                  </div>
                  <div className="form-group">
                    <label>Revenue</label>
                    <input type="number" name="revenue" value={formData.revenue} onChange={handleInputChange} step="0.01" placeholder="0.00" />
                  </div>
                  <div className="form-group">
                    <label>Monthly Cost</label>
                    <input type="number" name="monthly_cost" value={formData.monthly_cost} onChange={handleInputChange} step="0.01" placeholder="0.00" />
                  </div>
                  <div className="form-group">
                    <label>Quarterly Cost</label>
                    <input type="number" name="quarterly_cost" value={formData.quarterly_cost} onChange={handleInputChange} step="0.01" placeholder="0.00" />
                  </div>
                  <div className="form-group">
                    <label>Annual Cost</label>
                    <input type="number" name="annual_cost" value={formData.annual_cost} onChange={handleInputChange} step="0.01" placeholder="0.00" />
                  </div>
                  <div className="form-group">
                    <label>Payment Frequency</label>
                    <select name="payment_frequency" value={formData.payment_frequency} onChange={handleInputChange}>
                      <option value="Monthly">Monthly</option>
                      <option value="Quarterly">Quarterly</option>
                      <option value="Annual">Annual</option>
                    </select>
                  </div>
                </div>
              </div>

              <div className="form-section">
                <h3>Renewal Information</h3>
                <div className="form-row">
                  <div className="form-group">
                    <label>Last Renewal</label>
                    <input type="date" name="last_renewal" value={formData.last_renewal} onChange={handleInputChange} />
                  </div>
                  <div className="form-group">
                    <label>Next Renewal</label>
                    <input type="date" name="next_renewal" value={formData.next_renewal} onChange={handleInputChange} />
                  </div>
                </div>
              </div>

              <div className="form-section">
                <h3>Contact Information</h3>
                <div className="form-row">
                  <div className="form-group">
                    <label>SPOC 1 (Internal)</label>
                    <input type="text" name="spoc_1" value={formData.spoc_1} onChange={handleInputChange} placeholder="Internal contact" />
                  </div>
                  <div className="form-group">
                    <label>SPOC 2 (External)</label>
                    <input type="text" name="spoc_2" value={formData.spoc_2} onChange={handleInputChange} placeholder="External contact" />
                  </div>
                  <div className="form-group">
                    <label>Contact Number</label>
                    <input type="text" name="contact_no" value={formData.contact_no} onChange={handleInputChange} placeholder="Phone number" />
                  </div>
                  <div className="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email_id" value={formData.email_id} onChange={handleInputChange} placeholder="Email address" />
                  </div>
                </div>
              </div>

              <div className="form-section">
                <h3>Additional Information</h3>
                <div className="form-row">
                  <div className="form-group">
                    <label>Comments</label>
                    <textarea name="comments" value={formData.comments} onChange={handleInputChange} placeholder="Additional notes" rows="3"></textarea>
                  </div>
                  <div className="form-group">
                    <label>Reason for Using</label>
                    <textarea name="reason_for_using" value={formData.reason_for_using} onChange={handleInputChange} placeholder="Reason for using this tool" rows="3"></textarea>
                  </div>
                </div>
              </div>

              <div className="modal-actions">
                <button type="submit" className="btn-primary">
                  <i className="fas fa-save"></i> {editingTool ? 'Update Tool' : 'Save Tool'}
                </button>
                <button type="button" onClick={() => setShowModal(false)} className="btn-secondary">
                  <i className="fas fa-times"></i> Cancel
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default ToolManagement;
